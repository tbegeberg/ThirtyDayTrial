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
    func buttonClicked(context: AppContext, trial: Trial, view: UIViewController)
    func selectedItemFromList(context: AppContext, item: Trial)
    func swipedItemFromList(context: AppContext, item: Listable)
    func forward(context: AppContext)
    func back(context: AppContext)
    func enterState(context: AppContext)
}
