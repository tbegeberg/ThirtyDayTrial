//
//  Listable.swift
//  ThirtyDayTrial
//
//  Created by TørK on 07/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

protocol Listable {
    var title: String{ get }
    var cancelDate: Date{ get }
}

extension TrialPeriod: Listable {
    
    var title: String {
        get {
            return trialName
        }
    }
    var cancelDate: Date {
        get {
            return cancelDate
        }
    }
}
