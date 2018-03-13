//
//  TimeHandler.swift
//  30DayTrial
//
//  Created by TørK on 13/02/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

class TrialHandler {
    
    static let shared = TrialHandler ()
    
    var trialsArray = [TrialPeriod]()
    var array = [[String:Any]]()
    
    func getTrials(key: String, completion: @escaping ([TrialPeriod])-> ())  {
        if let json = UserDefaults.standard.object(forKey: key) as? [[String : Any]] {
            for trials in json {
                guard let jsonData = try? JSONSerialization.data(withJSONObject: trials) else { return }
                let decodedData = try? JSONDecoder().decode(TrialPeriod.self, from: jsonData)
                if let decodedTrial = decodedData {
                    if self.trialsArray.contains(where: { $0.uuid == decodedTrial.uuid}){
                        return
                    } else {
                        self.trialsArray.append(decodedTrial)
                    }
                }
            }
            completion(self.trialsArray)
        }
    }
    
    func setTrial(trialName: String, startdate: Date, endDate: Int, cancellationTime: Date) throws{
        let trial = TrialPeriod(trialName: trialName, startDate: startdate, endDate: endDate, cancellationTime: cancellationTime)
        if self.trialsArray.contains(where: { $0.trialName == trial.trialName}) {
            throw Error.TrialExcist("Trial \(trial.trialName) already exists")
        } else {
            self.trialsArray.append(trial)
        }
    }
    
    func deleteTrial(trialName: String, key: String) {
        let newTrialArray = self.trialsArray.filter {$0.trialName != trialName }
        self.trialsArray = newTrialArray
        self.saveTrials(key: key)
    }
    
    func saveTrials(key: String) {
        for trials in trialsArray {
            if let dictionaryTrial = trials.dictionary {
                self.array.append(dictionaryTrial)
            }
        }
        UserDefaults.standard.set(array, forKey: key)
    }

}
