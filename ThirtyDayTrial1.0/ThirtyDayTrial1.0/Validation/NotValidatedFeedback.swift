//
//  Validation.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

protocol NotValidatedFeedback {
    func showFeedback(problem:String)
}

extension UITextField: NotValidatedFeedback {
    func showFeedback(problem: String) {
        self.placeholder = problem
        self.layer.shadowColor = UIColor.red.cgColor
    }
}




