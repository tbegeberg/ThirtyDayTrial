//
//  UITextViewFactory.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 21/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class TextViewFactory {
    
    static func buildTextField() -> dateTextField {
        let textField = dateTextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextFieldViewMode.always
        textField.layer.masksToBounds = true
        textField.borderStyle = .none
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 0.0
        textField.textAlignment = .left
        textField.font = UIFont(name: textField.font!.fontName, size: 16)
        textField.sizeToFit()
        return textField
    }
    
    static func buildUILabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: label.font!.fontName, size: 10)
        label.sizeToFit()
        return label
    }
    
    static func setTextFieldsToDesign(view: AddTrialViewController) {
        view.trialName = TextViewFactory.buildTextField()
        view.trialStartDate = TextViewFactory.buildTextField()
        view.trialCancelDate = TextViewFactory.buildTextField()
        view.trialDays = TextViewFactory.buildTextField()
    }

}

