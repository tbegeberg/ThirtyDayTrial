//
//  Validatable.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

protocol Validatable {
    var textFieldID:String { get }
    var textFieldValue: UITextField { get }
}

extension UITextField: Validatable {
    
    var textFieldID: String {
        return self.textFieldID
    }
    
    var textFieldValue: UITextField {
        return self.textFieldValue
    }
}


