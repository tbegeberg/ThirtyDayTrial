//
//  StandardTrialPeriod.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 27/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

struct StandardTrial: Codable {

    var trialName: String
    var daysBeforeCancelTime: Int

    init(trialName: String, daysBeforeCancelTime: Int) {
        self.trialName = trialName
        self.daysBeforeCancelTime = daysBeforeCancelTime
    }
    
}
