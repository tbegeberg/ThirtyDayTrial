//
//  CustomUITextViews.swift
//  ThirtyDayTrial
//
//  Created by TørK on 01/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class CustomUITextField: UITextField, UITextFieldDelegate {

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.font = UIFont(name: (self.font?.fontName)!, size: 20)
        self.textAlignment = .center
        self.sizeToFit()
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.green.cgColor
    }
}

class CustomUILabel: UILabel {
    
    init(labelText: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.text = labelText
        self.textAlignment = .center
        self.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UITextField {
    var textVerifier:String {
        return self.text ?? ""
    }
}


