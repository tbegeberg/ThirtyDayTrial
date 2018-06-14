//
//  TimeHandler.swift
//  30DayTrial
//
//  Created by TørK on 13/02/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

//handle deleting localnotifier when deleting trial

class TrialHandler {
    
    static let shared = TrialHandler ()
    
    private var trialsArray = [Trial]()
    private var array = [[String:Any]]()
    
    func getTrialsOnDevice(completionHandler: @escaping ([Trial])->()) {
        if let json = UserDefaults.standard.object(forKey: "Trials") as? [[String : Any]] {
            for trials in json {
                guard let jsonData = try? JSONSerialization.data(withJSONObject: trials) else { return }
                let decodedData = try? JSONDecoder().decode(Trial.self, from: jsonData)
                if let decodedTrial = decodedData {
                    if self.trialsArray.contains(where: { $0.trialID == decodedTrial.trialID}){
                        continue
                    } else {
                        self.trialsArray.append(decodedTrial)
                    }
                }
            }
            completionHandler(self.trialsArray)
        }
    }
    
    func saveTrialOnDevice(trial: Trial) throws {
        let trialCancelHandler = TrialCancelHandler()
        let timeToCancelMinusOneDay = trialCancelHandler.secondsToCancelMinusOneDay(cancelDate: trial.cancellationTime)
        if timeToCancelMinusOneDay < 0 {
            throw TrialError.NoTimeInterval("Time interval must be greater than one day")
        } else {
            self.trialsArray.append(trial)
            self.setUserDefault()
            self.setLocalNotification(trial: trial, timeToCancelMinusOneDay: timeToCancelMinusOneDay)
        }
    }
    
    func deleteTrialOnDevice(trialID: UUID) {
        let array = self.trialsArray.filter {$0.trialID != trialID }
        self.trialsArray = array
        self.setUserDefault()
    }
    
    func setUserDefault() {
        self.array.removeAll()
        for trials in trialsArray {
            if let dictionaryTrial = trials.dictionary {
                self.array.append(dictionaryTrial)
            }
        }
        UserDefaults.standard.set(array, forKey: "Trials")
    }
    
    func setLocalNotification(trial: Trial, timeToCancelMinusOneDay: Double) {
        let notification = LocalNotifier()
        notification.title = "Trials"
        notification.subtitle = "Action Needed"
        notification.body = "\(trial.trialName) needs to be cancelled"
        notification.addLocalNotification(notification: notification, timeToCancelMinusOneDay: timeToCancelMinusOneDay)
    }

}
