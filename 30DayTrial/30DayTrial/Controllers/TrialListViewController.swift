//
//  ViewController.swift
//  30DayTrial
//
//  Created by TørK on 13/02/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit


class TrialListViewController: UIViewController {

    //Create visual of expiration
    
    @IBOutlet weak var trialTable: UITableView!
    var dataSource: TrialTableViewDatasource?
    let alert = AlertHelper()
    
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
                alert.timeToCancel(fromController: self, trialName: trial.trialName)
            }
        }
    }


}

