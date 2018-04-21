//
//  B.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class SearchListStandardTrials: State {
    
    func swipedItemFromList(context: AppContext, item: Listable) {
        
    }
    
    func selectedItemFromList(context: AppContext, item: TrialPeriod, sender: BaseListViewController) {
        let alert = AlertHelper()
        do {
            try TrialHandler.shared.setTrial(trialPeriod: item)
        }
        catch Error.TrialExcist(let description) {
            alert.showErrorAlert(fromController: sender, error: description)
            return
        } catch let error {
            alert.showErrorAlert(fromController: sender, error: error.localizedDescription)
            return
        }
        alert.showSuccessSave(fromController: sender, message: "Trial: \(item.trialName) has been saved")
        context.changeState(state: TrialsLoadedFromSave())
    }
    
    func forward(context: AppContext) {
        
    }
    
    func back(context: AppContext) {
        context.changeState(state: TrialsLoadedFromSave())
    }
    
    func enterState(context: AppContext) {
        let item = UIBarButtonItemActionable(title: "Back")
        let responder:ListViewResponder = context
        let view = ViewControllerFactory.buildSearchList(reponder: responder)
        item.actionBlock = {
            [weak self]
            () -> () in
            self?.back(context: context)
        }
        view.navigationItem.setLeftBarButton(item, animated: true)
        context.present(view: view)
    }
}
