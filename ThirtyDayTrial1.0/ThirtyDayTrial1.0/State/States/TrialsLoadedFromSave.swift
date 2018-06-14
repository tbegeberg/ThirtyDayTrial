//
//  A.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class TrialsLoadedFromSave: State {
    
    func buttonClicked(context: AppContext, trial: Trial, view: UIViewController) {
        
    }
    
    func swipedItemFromList(context: AppContext, item: Listable) {
        TrialHandler.shared.deleteTrialOnDevice(trialID: item.listID)
    }
    
    func selectedItemFromList(context: AppContext, item: Trial) {
        fatalError("This should not happen")
    }
    
    func forward(context: AppContext) {
       context.changeState(state: SearchStandardTrials())
    }
    
    func back(context: AppContext) {
        context.changeState(state: AddTrial())
    }

    func enterState(context: AppContext) {
        let trialCancelHandler = TrialCancelHandler()
        let responder:ListViewResponder = context
        let view = ViewControllerFactory.buildTrialsListView(reponder: responder)
        TrialHandler.shared.getTrialsOnDevice { (trials) in
            view.list = trials
            trialCancelHandler.findTrialNamesToCancel(trialArray: trials)
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
        trialCancelHandler.showCancelAlerts(controller: view)
    }
}
