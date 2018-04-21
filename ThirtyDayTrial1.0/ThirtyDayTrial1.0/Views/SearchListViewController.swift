//
//  SerchListViewController.swift
//  ThirtyDayTrial
//
//  Created by TørK on 29/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

class SearchListViewController: BaseListViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    private var trialsArray = [TrialPeriod]()
    private var standardTrialsArray: [TrialPeriod] = DataStandardTrials.createList() 
    private var filteredTrialsArray = [TrialPeriod]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        updateList(trials: standardTrialsArray)
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
        filteredTrialsArray = standardTrialsArray.filter({ (Trials) in
            let isMatchingSearchText = Trials.trialName.lowercased().contains(searchText.lowercased()) || searchText.isEmpty
            return isMatchingSearchText
        })
        updateList(trials: filteredTrialsArray)
    }
    
    func updateList(trials: [TrialPeriod]) {
        self.trialsArray = trials
        self.list = trials
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.responder?.itemClicked(item: self.trialsArray[indexPath.row], sender: self)
    }

}
