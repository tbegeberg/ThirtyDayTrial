//
//  SetStandardTrialsDate.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 29/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class AddStandardTrial: State {

    var trialChoosenFromSearchList: Trial
    
    init(trialChoosenFromSearchList: Trial) {
        self.trialChoosenFromSearchList = trialChoosenFromSearchList
    }
    
    func buttomClicked(context: AppContext, trialAndSender: TrialAndSender) {
        let buttonClickedHandler = ButtonClickedHandler()
        let alert = AlertHandler()
        let messageToUser = buttonClickedHandler.userClickedButtonToSaveTrialFeedback(item: trialAndSender.trial)
        alert.showAlert(fromController: trialAndSender.sender, title: messageToUser.0, message: messageToUser.1)
        if messageToUser.0 == "Success" {
            context.changeState(state: TrialsLoadedFromSave())
        }
    }
    
    func selectedItemFromList(context: AppContext, item: Trial) {
        
    }
    
    func swipedItemFromList(context: AppContext, item: Listable) {
        
    }
    
    func forward(context: AppContext) {
        
    }
    
    func back(context: AppContext) {
        context.changeState(state: TrialsLoadedFromSave())
    }
    
    func enterState(context: AppContext) {
        let responder: AddTrialViewResponder = context
        let view = ViewControllerFactory.buildAddStandardTrialView(reponder: responder, item: trialChoosenFromSearchList)
        let backButton = UIBarButtonItemActionable(title: "Trials")
        backButton.actionBlock = {
            [weak self]
            () -> () in
            self?.back(context: context)
        }
        view.navigationItem.setRightBarButton(backButton, animated: true)
        context.present(view: view)
    }
    
    
}
