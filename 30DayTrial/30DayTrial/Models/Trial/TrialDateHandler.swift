//
//  TrialDateHandler.swift
//  ThirtyDayTrial
//
//  Created by TørK on 27/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class TrialDateHandler {
    
    let calendar = NSCalendar.current
    let date = Date()
    
    func secondsToCancelMinusOneDay(cancelDate: Date) -> Double {
        let currentDate = calendar.startOfDay(for: date)
        let cancelDate = calendar.startOfDay(for: cancelDate)
        let components = calendar.dateComponents([.second], from: currentDate, to: cancelDate)
        if let seconds = components.second {
            print("seonds added to notification")
            return (Double(seconds - 86400))
        }
        return 0
    }
    
    func timeToCancelTrial(cancelDate: Date) -> Bool {
        let currentDate = calendar.startOfDay(for: date)
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
