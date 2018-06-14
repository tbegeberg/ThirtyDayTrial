//
//  SerchListViewController.swift
//  ThirtyDayTrial
//
//  Created by TørK on 29/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

protocol SearclistViewControllerDelegate:class {
    func SearchListWasClickedAndSaved(sender: SearchListViewController, item: TrialPeriod)
}

class SearchListViewController: BaseListViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    private var standardTrials: [TrialPeriod] = DataStandardTrials.createList()
    private var filteredTrialsList = [TrialPeriod]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        updateDataSouce(trials: standardTrials)
    }

    func updateSearchResults(for searchController: UISearchController) {
        filterSearch(serchBar: searchController.searchBar)
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
    
    func updateDataSouce(trials: [TrialPeriod]) {
        self.dataSource = TrialTableViewDatasource(trials: trials, editEnabled: false)
        self.tableView.dataSource = self.dataSource
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trial = self.standardTrials[indexPath.row]
        let alert = AlertHelper()
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
