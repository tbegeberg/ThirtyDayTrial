//
//  StringHolder.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

struct StringHolder {
    var textFieldID:String
    var textField:UITextField
}

extension StringHolder: Validatable {
    var textFieldName: String {
        return self.textFieldID
    }
    var textFieldValue: UITextField {
        return self.textField
    }
}




    
    





    
    






