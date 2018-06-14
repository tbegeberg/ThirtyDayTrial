//
//  ValidatorRule.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

protocol ValidatorRule {
    func isValid(validatable:Validatable) throws
}

class IsNotEmptyRule:ValidatorRule {
    
    func isValid(validatable: Validatable) throws {
        if validatable.textField.text == "" {
            throw ValidatorError.StringWasEmpty(validatable)
        }
    }
}

class IsNotANumber:ValidatorRule {
    
    func isValid(validatable: Validatable) throws {
      
        if validatable.textField.textVerifier.isNumeric == false {
            throw ValidatorError.StringWasEmpty(validatable)
        }
    }
}



extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
}
