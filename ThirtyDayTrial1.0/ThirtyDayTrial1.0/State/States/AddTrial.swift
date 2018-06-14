//
//  AddCustomizedTrial.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 16/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class AddTrial: State {
    
    func buttonClicked(context: AppContext, trial: Trial, view: UIViewController) {
        let buttonClickedHandler = ButtonClickedHandler()
        let alert = AlertHandler()
        let messageToUser = buttonClickedHandler.feedback(item: trial)
        alert.showAlert(fromController: view, title: messageToUser.0, message: messageToUser.1)
        if messageToUser.0 == "Success" {
          context.changeState(state: TrialsLoadedFromSave())
        }
    }
    
    func swipedItemFromList(context: AppContext, item: Listable) {
        
    }
    
    func selectedItemFromList(context: AppContext, item: Trial) {
        
    }
    
    func forward(context: AppContext) {
        
    }
    
    func back(context: AppContext) {
        context.changeState(state: TrialsLoadedFromSave())
    }
    
    func enterState(context: AppContext) {
        let responder: AddTrialViewResponder = context
        let view = ViewControllerFactory.buildAddCustomTrialView(reponder: responder)
        let backButton = UIBarButtonItemActionable(title: "Back")
        backButton.actionBlock = {
            [weak self]
            () -> () in
            self?.back(context: context)
        }
        view.navigationItem.setRightBarButton(backButton, animated: true)
        context.present(view: view)
    }

    
}
