//
//  AddCustomizedTrial.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 16/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class AddCustomTrial: State {
    
    func swipedItemFromList(context: AppContext, item: Listable) {
        
    }
    
    func selectedItemFromList(context: AppContext, item: TrialPeriod, sender: BaseListViewController) {
        
    }
    
    func forward(context: AppContext) {
        
    }
    
    func back(context: AppContext) {
        context.changeState(state: TrialsLoadedFromSave())
    }
    
    func enterState(context: AppContext) {
        let view = ViewControllerFactory.buildCustomTrial()
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
