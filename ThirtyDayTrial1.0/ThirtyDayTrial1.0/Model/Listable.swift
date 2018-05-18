//
//  Listable.swift
//  ThirtyDayTrial
//
//  Created by TørK on 07/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

protocol Listable {
    var title: String { get }
    var subtitle: String { get }
    var listID: UUID { get }
}

extension Trial: Listable {
    
    var title: String {
        get {
            return trialName
        }
    }
    var subtitle: String {
        get {
            let dateFormatter = DateFormatable()
            let value = "Cancel by: \(dateFormatter.string(from: cancellationTime))"
            return value
        }
    }
    
    var listID: UUID {
        get {
            return trialID
        }
    }
}

extension StandardTrial: Listable {
    var listID: UUID {
        return UUID()
    }

    var title: String {
        get {
            return trialName
        }
    }
    var subtitle: String {
        get {
            let value = "Cancel after: \(String(daysBeforeCancelTime)) days"
            return value
        }
    }
    
   
}
