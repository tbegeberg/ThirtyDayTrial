//
//  ViewControllerFactory.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 13/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class ViewControllerFactory {
    
    static func buildTrialsList(reponder: ListViewResponder) -> BaseListViewController {
        let trialListViewController = BaseListViewController()
        trialListViewController.editEeditListEnabled = true
        trialListViewController.responder = reponder
        trialListViewController.title = "Trials"
        return trialListViewController
    }
    
    static func buildSearchList(reponder: ListViewResponder) -> SearchListViewController {
        let searchListViewController = SearchListViewController()
        searchListViewController.editEeditListEnabled = false
        searchListViewController.responder = reponder
        searchListViewController.title = "Search and Add Trials"
        return searchListViewController
    }
    
    static func buildCustomTrial() -> CustomTrialViewController {
        let customTrialViewController = CustomTrialViewController()
        customTrialViewController.title = "Add Custom Trial"
        return customTrialViewController
    }
    
    
}
