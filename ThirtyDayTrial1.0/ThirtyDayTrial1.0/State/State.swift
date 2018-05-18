//
//  States.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

protocol State {
    func buttomClicked(context: AppContext, trialAndSender: TrialAndSender)
    func selectedItemFromList(context: AppContext, item: Trial)
    func swipedItemFromList(context: AppContext, item: Listable)
    func forward(context: AppContext)
    func back(context: AppContext)
    func enterState(context: AppContext)
}
