//
//  A.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

struct TrialsLoadedFromSave: State {
    
    let trials: [TrialPeriod]
    
    func selectTrial() {
        
    }
    
    func goToStandardTrials() {
        
    }
    
    func back() {
        
    }
    
    func enterState(context: AppdelegateContext) {
        context.showSavedTrials(trials: self.trials)
    }
    

    
    
}
