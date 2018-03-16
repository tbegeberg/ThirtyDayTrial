//
//  ViewController.swift
//  30DayTrial
//
//  Created by TørK on 13/02/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

class TrialViewController: UIViewController {

    
    //Create alarm
    //Create visual of expiration
    
    @IBOutlet weak var trialTable: UITableView!
    var dataSource: TrialTableViewDatasource?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
    
        TrialHandler.shared.getTrials(completion: { trial in
            print(trial)
        })
        
        self.dataSource = TrialTableViewDatasource(trials: TrialHandler.shared.trialsArray)
        self.trialTable.dataSource = dataSource
        self.trialTable.reloadData()

    }
    
    

}

