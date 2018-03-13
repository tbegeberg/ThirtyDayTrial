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
        if validatable.textFieldValue.text == "" {
            
            if let feedbacker = validatable.textFieldValue as? NotValidatedFeedback {
                feedbacker.showFeedback(problem: "Please enter a \(validatable.textFieldName)")
            }
            
            throw ValidatorError.StringWasEmpty("Empty field")
        } else {
            validatable.textFieldValue.validaded()
        }
    }
}

class IsNotANumber:ValidatorRule {
    
    func isValid(validatable: Validatable) throws {
      
        if validatable.textFieldValue.textVerifier.isNumeric == false {
            if let feedbacker = validatable.textFieldValue as? NotValidatedFeedback {
                feedbacker.showFeedback(problem: "Please enter a number")
            }
            throw ValidatorError.StringWasEmpty("Please enter a number in \(validatable.textFieldName)")
        }
        else {
            validatable.textFieldValue.validaded()
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
