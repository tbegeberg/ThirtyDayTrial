//
//  ServerError.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 25/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//


struct ServerError: Codable {
    
    var identifier: String
    var reason: String
    var debugReason: String
    var error: Bool
    
    init() {
        self.identifier = ""
        self.reason = ""
        self.debugReason = ""
        self.error = true
    }
    
    init(identifier: String, reason: String, debugReason: String, error: Bool) {
        self.identifier = identifier
        self.reason = reason
        self.debugReason = debugReason
        self.error = error
    }
    
    init(json: [String:Any]) throws {
        
        guard let identifier = json["identifier"] as? String else {
            throw NetworkError.missing("Missing identifier Error Model")
        }
        guard let reason = json["reason"] as? String else {
            throw NetworkError.missing("Missing reason Error Model")
        }
        guard let debugReason = json["debugReason"] as? String else {
            throw NetworkError.missing("Missing debugReason Error Model")
        }
        guard let error = json["error"] as? Bool else {
            throw NetworkError.missing("Missing error Error Model")
        }
        
        self.identifier = identifier
        self.reason = reason
        self.debugReason = debugReason
        self.error = error
    }
    
}

extension ServerError {
    
    enum CodingKeys: String, CodingKey {
        case identifier = "identifier"
        case reason = "reason"
        case debugReason = "debugReason"
        case error = "error"
        
    }
}
