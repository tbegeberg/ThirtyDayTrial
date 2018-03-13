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
    
    init(trials: [TrialPeriod]) {
        self.trials = trials
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
}