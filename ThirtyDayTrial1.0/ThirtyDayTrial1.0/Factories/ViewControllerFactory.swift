//
//  ViewControllerFactory.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 13/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class ViewControllerFactory {
    
    static func buildTrialsListView(reponder: ListViewResponder) -> BaseListViewController {
        let trialListViewController = BaseListViewController()
        trialListViewController.editEeditListEnabled = true
        trialListViewController.responder = reponder
        trialListViewController.title = "Trials"
        return trialListViewController
    }
    
    static func buildSearchListView(reponder: ListViewResponder) -> SearchListViewController {
        let searchListViewController = SearchListViewController()
        searchListViewController.editEeditListEnabled = false
        searchListViewController.responder = reponder
        searchListViewController.title = "Click to add trial"
        return searchListViewController
    }
    
    static func buildAddCustomTrialView(reponder: AddTrialViewResponder) -> AddTrialViewController {
        let customTrialViewController = AddTrialViewController()
        TextViewFactory.setTextFieldsToDesign(view: customTrialViewController)
        TextViewFactory.setTextFieldsDelegate(view: customTrialViewController)
        customTrialViewController.responder = reponder
        customTrialViewController.title = "Enter Trial Info"
        return customTrialViewController
    }
    
    static func buildAddStandardTrialView(reponder: AddTrialViewResponder, item: Trial) -> AddTrialViewController {
        let customTrialViewController = AddTrialViewController()
        TextViewFactory.setTextFieldsToDesign(view: customTrialViewController)
        TextViewFactory.setTextFieldsDelegate(view: customTrialViewController)
        ViewModel.fillTextFields(trial: item, view: customTrialViewController)
        ViewModel.setDates(trial: item, view: customTrialViewController)
        customTrialViewController.responder = reponder
        customTrialViewController.title = "Save or Change Dates"
        return customTrialViewController
    }

    
}
