//
//  ViewModel.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 01/05/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation


class ViewModel {
    
    static func fillTextFields(trial: Trial, view: AddTrialViewController) {
        let dateFormatter = DateFormatable()
        view.trialName.textField.text = trial.trialName
        view.trialStartDate.textField.text = dateFormatter.string(from: trial.startDate)
        view.trialCancelDate.textField.text = dateFormatter.string(from: trial.cancellationTime)
        view.trialDays.textField.text = String(trial.daysBeforeCancelTime)
    }
    
    static func setDates(trial: Trial, view: AddTrialViewController) {
        view.trialStartDate.date = trial.startDate
        view.trialCancelDate.date = trial.cancellationTime
    }
}



