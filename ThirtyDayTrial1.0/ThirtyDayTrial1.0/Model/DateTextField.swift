//
//  DateTextField.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 22/05/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class dateTextField: UITextField {
    
    var dateValue: Date?
    var date: Date {
        get{
            return dateValue ?? Date()
        }
        set(newValue){
            dateValue = newValue
        } }

}




//extension UItextfiled func get set date og subclass  date var get set

