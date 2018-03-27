//
//  TrialDateHandler.swift
//  ThirtyDayTrial
//
//  Created by TørK on 27/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class TrialDateHandler {
    
    func timeToCancelTrial(cancelDate: Date) -> Bool {
        let calendar = NSCalendar.current
        let currentDate = calendar.startOfDay(for: Date())
        let cancelDate = calendar.startOfDay(for: cancelDate)
        let components = calendar.dateComponents([.day], from: currentDate, to: cancelDate)
        if let days = components.day {
            if days <= 1 {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    
    
}
