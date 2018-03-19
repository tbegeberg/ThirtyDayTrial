//
//  StandardTrialViewController.swift
//  ThirtyDayTrial
//
//  Created by TørK on 16/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

class StandardTrialViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
   
    //Add standard by search
    //Add listview for search
    //Array with all standard trisl
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: TrialTableViewDatasource?
    private var standardTrials: [TrialPeriod] = [TrialPeriod(trialName: "Netflix", startDate: Date(), endDate: 30, cancellationTime: Date.distantFuture), TrialPeriod(trialName: "Amazon", startDate: Date(), endDate: 20, cancellationTime: Date.distantFuture)]
    private var filteredTrialsList = [TrialPeriod]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        updateDataSouce(trials: standardTrials)
        
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
        self.dataSource = TrialTableViewDatasource(trials: trials)
        self.tableView.dataSource = dataSource
        self.tableView.reloadData()
    }


}
