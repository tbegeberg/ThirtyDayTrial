//
//  ViewController.swift
//  30DayTrial
//
//  Created by TørK on 13/02/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit
import AVFoundation

class TrialListViewController: UIViewController {

    //Create visual of expiration
    
    @IBOutlet weak var trialTable: UITableView!
    var dataSource: TrialTableViewDatasource?
    private var trialsCancelArray = [String]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        TrialHandler.shared.getTrials(completion: { trial in
            print(trial)
        })
        
        self.dataSource = TrialTableViewDatasource(trials: TrialHandler.shared.trialsArray, editEnabled: true)
        self.trialTable.dataSource = dataSource
        self.trialTable.reloadData()
        
        for trial in TrialHandler.shared.trialsArray {
            let cancelTime = trial.cancellationTime
            let trialDateHandler = TrialDateHandler()
            if trialDateHandler.timeToCancelTrial(cancelDate: cancelTime) == true {
                trialsCancelArray.append(trial.trialName)
            }
        }
        showCancelAlerts()
    }

    func showCancelAlerts() {
        if let trialToCancel = trialsCancelArray.first {
            AudioServicesPlayAlertSound(SystemSoundID(1322))
            let alert = UIAlertController(title: "Alert", message: "Time To Cancel Trial: \(trialToCancel)", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default) { action in
                self.trialsCancelArray.remove(at: 0) // remove the message of the alert we have just dismissed
                self.showCancelAlerts()
            }
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
        }
    }

}

