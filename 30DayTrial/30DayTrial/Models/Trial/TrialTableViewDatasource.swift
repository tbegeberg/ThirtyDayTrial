//
//  TrialTableViewDatasource.swift
//  ThirtyDayTrial
//
//  Created by TørK on 01/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class TrialTableViewDatasource: NSObject, UITableViewDataSource {
    
    var trials: [TrialPeriod]
    var editEnabled: Bool?
    
    init(trials: [TrialPeriod], editEnabled: Bool) {
        self.trials = trials
        self.editEnabled = editEnabled
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let trials = self.trials[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        cell.textLabel?.text = "\(trials.trialName) - Cancel by: \(dateFormatter.string(from: trials.cancellationTime))"
        return cell
    }
    

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if editEnabled == true {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TrialHandler.shared.deleteTrial(trialID: self.trials[indexPath.row].trialID)
            trials.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
