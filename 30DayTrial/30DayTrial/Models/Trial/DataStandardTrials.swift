//
//  DataStandardTrials.swift
//  ThirtyDayTrial
//
//  Created by TørK on 20/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class DataStandardTrials: NSObject {

    class func createList()  -> [TrialPeriod] {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.month = 1
        guard let range = Calendar.current.range(of: .day, in: .month, for: currentDate) else {
            fatalError("Calender produced no range")
        }
        
        guard let plusOneMonth = Calendar.current.date(byAdding: dateComponent, to: currentDate) else {
            fatalError("Calender produced no date")
        }
        
        return [TrialPeriod(trialName: "HBO", startDate: currentDate, endDate: range.count, cancellationTime: plusOneMonth), TrialPeriod(trialName: "NetFlix", startDate: currentDate, endDate: range.count, cancellationTime: plusOneMonth)]
        
       
    }
    
}
