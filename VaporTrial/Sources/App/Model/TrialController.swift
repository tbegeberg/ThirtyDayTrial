//
//  TrialController.swift
//  App
//
//  Created by TørK on 13/05/2018.
//

import Foundation
import Vapor

final class TrialController {
    
    func index(_ req: Request) throws -> Future<[Trial]> {
        return Trial.query(on: req).all()
    }
    
    
    
}
