//
//  UITextViewFactory.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 21/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class UITextViewFactory {
    
    static func buildTextField(tag: Int, delegate: UITextFieldDelegate) -> UITextField {
        let textField = UITextField()
        textField.tag = tag
        textField.delegate = delegate
        textField.layer.cornerRadius = 6.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.textAlignment = .center
        textField.sizeToFit()
        return textField
    }
    
    static func buildTextFieldDatePicer(tag: Int, delegate: UITextFieldDelegate, inputView: UIDatePicker, inputAccessoryView: UIToolbar) -> UITextField {
        let textField = UITextField()
        textField.tag = tag
        textField.inputView = inputView
        textField.inputAccessoryView = inputAccessoryView
        textField.delegate = delegate
        textField.layer.cornerRadius = 6.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.textAlignment = .center
        textField.sizeToFit()
        return textField
    }
    
   


}
