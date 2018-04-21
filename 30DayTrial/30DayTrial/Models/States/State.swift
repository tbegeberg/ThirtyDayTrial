//
//  States.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

protocol State {
    func selectTrial()
    func goToStandardTrials()
    func back()
    func enterState(context: AppdelegateContext)
}
