//
//  Appcontext.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

protocol AppdelegateContext {
    func showStandardTrials()
    func showSavedTrials(trials: [TrialPeriod])
    func changeState(state: State)
}




