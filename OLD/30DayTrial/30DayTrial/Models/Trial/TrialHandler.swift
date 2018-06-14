//
//  TimeHandler.swift
//  30DayTrial
//
//  Created by TørK on 13/02/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class TrialHandler {
    
    //TrialManager imellem UI og DB(TrialHandler)
    
    static let shared = TrialHandler ()
    
    var trialsArray = [TrialPeriod]()
    var array = [[String:Any]]()
    
    func getTrials(completionHandler: @escaping ([TrialPeriod])->()) {
        if let json = UserDefaults.standard.object(forKey: "Trials") as? [[String : Any]] {
            for trials in json {
                guard let jsonData = try? JSONSerialization.data(withJSONObject: trials) else { return }
                let decodedData = try? JSONDecoder().decode(TrialPeriod.self, from: jsonData)
                if let decodedTrial = decodedData {
                    if self.trialsArray.contains(where: { $0.trialID == decodedTrial.trialID}){
                        return
                    } else {
                        self.trialsArray.append(decodedTrial)
                    }
                }
            }
            completionHandler(self.trialsArray)
        }
    }
    
    func setTrial(trialPeriod: TrialPeriod) throws{
        let trial = trialPeriod
        if self.trialsArray.contains(where: { $0.trialName == trial.trialName}) {
            throw Error.TrialExcist("Trial \(trial.trialName) already exists")
        } else {
            self.trialsArray.append(trial)
            self.saveTrials()
            let trialDateHandler = TrialCancelDateHandler()
            let timeToCancelMinusOneDay = trialDateHandler.secondsToCancelMinusOneDay(cancelDate: trial.cancellationTime)
            let notification = LocalNotifier()
            notification.title = "Trials"
            notification.subtitle = "Action Needed"
            notification.body = "\(trial.trialName) needs to be cancelled"
            notification.addLocalNotification(notification: notification, timeToCancelMinusOneDay: timeToCancelMinusOneDay)
        }
        
    }
    
    func deleteTrial(trialID: UUID) {
        let newTrialArray = self.trialsArray.filter {$0.trialID != trialID }
        self.trialsArray = newTrialArray
        self.saveTrials()
    }
    
    func saveTrials() {
        self.array.removeAll()
        for trials in trialsArray {
            if let dictionaryTrial = trials.dictionary {
                self.array.append(dictionaryTrial)
            }
        }
        UserDefaults.standard.set(array, forKey: "Trials")
    }
    
   

}
