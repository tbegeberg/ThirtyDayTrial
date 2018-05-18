//
//  B.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class SearchStandardTrials: State {
    
    func buttomClicked(context: AppContext, trialAndSender: TrialAndSender) {
        
    }
    
    func swipedItemFromList(context: AppContext, item: Listable) {
        
    }
    
    func selectedItemFromList(context: AppContext, item: Trial) {
        context.changeState(state: AddStandardTrial(trialChoosenFromSearchList: item))
    }
    
    func forward(context: AppContext) {
        
    }
    
    func back(context: AppContext) {
        context.changeState(state: TrialsLoadedFromSave())
    }
    
    func enterState(context: AppContext) {
        let item = UIBarButtonItemActionable(title: "Back")
        let responder:ListViewResponder = context
        let view = ViewControllerFactory.buildSearchListView(reponder: responder)
        item.actionBlock = {
            [weak self]
            () -> () in
            self?.back(context: context)
        }
        view.navigationItem.setLeftBarButton(item, animated: true)
        context.present(view: view)
    }
}
