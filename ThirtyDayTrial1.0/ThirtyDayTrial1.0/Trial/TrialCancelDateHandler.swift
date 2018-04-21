//
//  TrialDateHandler.swift
//  ThirtyDayTrial
//
//  Created by TørK on 27/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class TrialCancelDateHandler {
    
    private let calendar = NSCalendar.current
    private let date = Date()
    private var trialsToCancelArray = [String]()
    
    func secondsToCancelMinusOneDay(cancelDate: Date) -> Double {
        let currentDate = calendar.startOfDay(for: date)
        let cancelDate = calendar.startOfDay(for: cancelDate)
        let components = calendar.dateComponents([.second], from: currentDate, to: cancelDate)
        if let seconds = components.second {
            return (Double(seconds - 86339))
        }
        return 0
    }
    
    func timeToCancelTrial(cancelDate: Date) -> Bool {
        let currentDate = calendar.startOfDay(for: date)
        let cancelDate = calendar.startOfDay(for: cancelDate)
        let components = calendar.dateComponents([.day], from: currentDate, to: cancelDate)
        if let days = components.day {
            if days <= 1 {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func findTrialNamesToCancel(trialArray: [TrialPeriod]) {
        self.trialsToCancelArray = [String]()
        for trial in trialArray {
            let cancelTime = trial.cancellationTime
            let trialDateHandler = TrialCancelDateHandler()
            if trialDateHandler.timeToCancelTrial(cancelDate: cancelTime) == true {
                trialsToCancelArray.append(trial.trialName)
            }
        }
    }
    
    func showCancelAlerts(controller: UIViewController) {
        let controller = controller
        if let trialToCancel = self.trialsToCancelArray.first {
            AudioServicesPlayAlertSound(SystemSoundID(1322))
            let alert = UIAlertController(title: "Alert", message: "Time To Cancel Trial: \(trialToCancel)", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default) { action in
                self.trialsToCancelArray.remove(at: 0)
                self.showCancelAlerts(controller: controller)
            }
            alert.addAction(okayAction)
            controller.present(alert, animated: true, completion: nil)
        }
    }

}
