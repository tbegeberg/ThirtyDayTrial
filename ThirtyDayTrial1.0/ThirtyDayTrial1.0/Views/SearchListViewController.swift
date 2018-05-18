//
//  SerchListViewController.swift
//  ThirtyDayTrial
//
//  Created by TørK on 29/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit
import SnapKit

class SearchListViewController: BaseListViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var trialsArray = [Trial]()
    private var standardTrialsArray = [StandardTrial]()
    private var filteredStandardTrialsArray = [StandardTrial]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        getStandardTrialsFromServer()
    }

    func updateSearchResults(for searchController: UISearchController) {
        filterSearch(serchBar: searchController.searchBar)
        updateList(trials: filteredStandardTrialsArray)
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search by trial name"
        searchController.searchBar.delegate = self
    }
    
    func filterSearch(serchBar: UISearchBar) {
        let searchText = serchBar.text ?? ""
        filteredStandardTrialsArray = standardTrialsArray.filter({ (Trials) in
            let isMatchingSearchText = Trials.trialName.lowercased().contains(searchText.lowercased()) || searchText.isEmpty
            return isMatchingSearchText
        })
        
    }
    
    func updateList(trials: [StandardTrial]) {
        self.list = trials
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemClicked = self.filteredStandardTrialsArray[indexPath.row]
        if let trial = self.convertStandardTrialToTrial(standardTrial: itemClicked) {
            self.responder?.itemClicked(item: trial)
        }
    }
    
    func getStandardTrialsFromServer () {
        NetworkHandler.shared.getJSON (url: "http://0.0.0.0:8080/trials/") { (result:Result<[StandardTrial]>) in
            switch result {
            case .success(let value):
                for trial in value {
                    self.standardTrialsArray.append(trial)
                }
                self.updateList(trials: self.standardTrialsArray)
                self.filteredStandardTrialsArray = self.standardTrialsArray
            case .serverError(let error):
                print(error)
            case .error(let error):
                print(error)
            }
        }
    }
    
    
    func convertStandardTrialToTrial(standardTrial: StandardTrial) -> Trial? {
        if let cancellationTime = Calendar.current.date(byAdding: .day, value: standardTrial.daysBeforeCancelTime, to: Date()) {
            let trial = Trial(trialName: standardTrial.trialName, startDate: Date(), daysBeforeCancelTime: standardTrial.daysBeforeCancelTime, cancellationTime: cancellationTime)
            return trial
        }
        return nil
    }

}
