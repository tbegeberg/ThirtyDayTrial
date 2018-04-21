//
//  A.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class TrialsLoadedFromSave: State {
    
    func swipedItemFromList(context: AppContext, item: Listable) {
        TrialHandler.shared.deleteTrial(trialID: item.listID)
    }
    
    func selectedItemFromList(context: AppContext, item: TrialPeriod, sender: BaseListViewController) {
        
    }
    
    func forward(context: AppContext) {
       context.changeState(state: SearchListStandardTrials())
    }
    
    func back(context: AppContext) {
        context.changeState(state: AddCustomTrial())
    }

    func enterState(context: AppContext) {
        let trialCancelDateHandler = TrialCancelDateHandler()
        let responder:ListViewResponder = context
        let view = ViewControllerFactory.buildTrialsList(reponder: responder)
        TrialHandler.shared.getTrials { (trials) in
            view.list = trials
            trialCancelDateHandler.findTrialNamesToCancel(trialArray: trials)
        }
        let addTrialButton = UIBarButtonItemActionable(title: "Add")
        addTrialButton.actionBlock = {
            [weak self]
            () -> () in
            self?.forward(context: context)
        }
        let addCustomTrialButton = UIBarButtonItemActionable(title: "Custom")
        addCustomTrialButton.actionBlock = {
            [weak self]
            () -> () in
            self?.back(context: context)
        }
        view.navigationItem.setLeftBarButton(addCustomTrialButton, animated: true)
        view.navigationItem.setRightBarButton(addTrialButton, animated: true)
        context.present(view: view)
        //trialCancelDateHandler.showCancelAlerts(controller: view)
    }
}
