//
//  UIControlsFactory.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 21/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class UIControlsFactory {
    
    static func buildDatePicer() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.backgroundColor = UIColor.white
        return datePicker
    }
    
    static func buildButton(title: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = UIColor(red: 14/255, green: 122/255, blue: 254/255, alpha: 1.0).cgColor
        button.layer.borderWidth = 1
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: (button.titleLabel?.font.fontName)!, size: 15)
        button.backgroundColor = UIColor(red: 14/255, green: 122/255, blue: 254/255, alpha: 1.0)
        button.sizeToFit()
        return button
        
    }
    
}
