//
//  LocalizedError.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 25/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case missing(String)
    case urlError(reason: String)
    case objectSerialization(reason: String)
}
