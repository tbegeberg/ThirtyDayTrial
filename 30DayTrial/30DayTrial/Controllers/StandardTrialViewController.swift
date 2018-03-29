//
//  StandardTrialViewController.swift
//  ThirtyDayTrial
//
//  Created by TørK on 16/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

class StandardTrialViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate {
    
    //Remove cancel time fra standard list
    
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: TrialTableViewDatasource?
    private var standardTrials: [TrialPeriod] = DataStandardTrials.createList()
    private var filteredTrialsList = [TrialPeriod]()
    let searchController = UISearchController(searchResultsController: nil)
    let alert = AlertHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        updateDataSouce(trials: standardTrials)
        self.tableView.delegate = self
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Enter trial"
        searchController.searchBar.delegate = self
    }
    
    func filterSearch(serchBar: UISearchBar) {
       let searchText = serchBar.text ?? ""
        filteredTrialsList = standardTrials.filter({ (Trials) in
            let isMatchingSearchText = Trials.trialName.lowercased().contains(searchText.lowercased()) || searchText.isEmpty
            return isMatchingSearchText
        })
        updateDataSouce(trials: filteredTrialsList)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
       filterSearch(serchBar: searchController.searchBar)
    }
    
    func updateDataSouce(trials: [TrialPeriod]) {
        self.dataSource = TrialTableViewDatasource(trials: trials, editEnabled: false)
        self.tableView.dataSource = dataSource
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trial = self.standardTrials[indexPath.row]
        do {
            try TrialHandler.shared.setTrial(trialPeriod: trial)
        }
        catch Error.TrialExcist(let description) {
            alert.showErrorAlert(fromController: self, error: description)
        } catch let error {
            alert.showErrorAlert(fromController: self, error: error.localizedDescription)
        }
        alert.showSuccessSave(fromController: self)
    }
    

}
