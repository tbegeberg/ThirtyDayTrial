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
    func selectedItemFromList(context: AppContext, item: TrialPeriod, sender: BaseListViewController)
    func swipedItemFromList(context: AppContext, item: Listable)
    func forward(context: AppContext)
    func back(context: AppContext)
    func enterState(context: AppContext)
}
