//
//  Result.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 25/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

enum Result<T> {
    case success(T)
    case error(Error)
    case serverError(ServerError)
}
