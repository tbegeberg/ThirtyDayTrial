//
//  ValidadedFeedback.swift
//  ThirtyDayTrial
//
//  Created by TørK on 09/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

protocol ValidatedFeedback {
    func validaded()
}

extension UITextField: ValidatedFeedback {
    func validaded() {
        self.layer.borderColor = UIColor.green.cgColor
    }
}
