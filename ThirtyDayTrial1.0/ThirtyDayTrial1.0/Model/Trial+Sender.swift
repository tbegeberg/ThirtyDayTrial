//
//  TrialAndSender.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 11/05/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

struct TrialAndSender {
    var trial: Trial
    var sender: UIViewController
    
    init(trial: Trial, sender: UIViewController) {
        self.trial = trial
        self.sender = sender
    }
}
