//
//  CustomUIControls.swift
//  ThirtyDayTrial
//
//  Created by TørK on 01/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class CustomUIButton: UIButton {
    
    init(title: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = UIColor(red: 14/255, green: 122/255, blue: 254/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 1
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(name: (self.titleLabel?.font.fontName)!, size: 15)
        self.backgroundColor = UIColor(red: 14/255, green: 122/255, blue: 254/255, alpha: 1.0)
        self.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CustomUIDatePicker: UIDatePicker {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.datePickerMode = .date
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





