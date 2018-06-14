//
//  Validatable.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

protocol Validatable {
    var textField: UITextField { get }
}

extension UITextField: Validatable {
    var textField: UITextField {
        return self
    }
}





