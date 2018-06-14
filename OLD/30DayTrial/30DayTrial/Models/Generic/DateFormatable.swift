//
//  DateFormatter.swift
//  ThirtyDayTrial
//
//  Created by TørK on 27/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class DateFormatable: DateFormatter {

    override init() {
        super.init()
        self.timeStyle = DateFormatter.Style.none
        self.dateStyle = DateFormatter.Style.medium
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
