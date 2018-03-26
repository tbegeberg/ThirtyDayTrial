//
//  StandardTrialViewController.swift
//  ThirtyDayTrial
//
//  Created by TørK on 16/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

class StandardTrialViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate {
   
    //Add standard by search
    //Add listview for search
    //Array with all standard trisl
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: TrialTableViewDatasource?
    private var standardTrials: [TrialPeriod] = DataStandardTrials.createList()
    private var filteredTrialsList = [TrialPeriod]()
    private let searchController = UISearchController(searchResultsController: nil)
    
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
        TrialHandler.shared.trialsArray.append(trial)
    }
    
    


}
