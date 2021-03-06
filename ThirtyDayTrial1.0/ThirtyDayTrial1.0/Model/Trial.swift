//
//  States.swift
//  30DayTrial
//
//  Created by TørK on 13/02/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

struct Trial: Codable {
    var trialID: UUID
    var trialName: String
    var startDate: Date
    var daysBeforeCancelTime: Int
    var cancellationTime: Date
    
    init(trialName: String, startDate: Date, daysBeforeCancelTime: Int, cancellationTime: Date) {
        self.trialID = UUID()
        self.trialName = trialName
        self.startDate = startDate
        self.daysBeforeCancelTime = daysBeforeCancelTime
        self.cancellationTime = cancellationTime
    }
    
    var dictionary: [String : Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }

}



