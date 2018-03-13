//
//  StringValidator.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

class StringValidator {
    
    var rules:[ValidatorRule]
    var subjects:[Validatable]
    
    init(rules:[ValidatorRule],subjects:[Validatable]) {
        self.rules = rules
        self.subjects = subjects
    }
    
    func validate() throws {
        try rules.forEach { (rule) in
            try subjects.forEach({ (validatable) in
                try rule.isValid(validatable: validatable)
            })
        }
    }
    
}
