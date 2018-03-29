//
//  BaseListViewController.swift
//  ThirtyDayTrial
//
//  Created by TørK on 28/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit
import AVFoundation

class BaseListViewController: UITableViewController {
    
    var trialArray = [TrialPeriod]()
    var dataSource: UITableViewDataSource?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.tableView.dataSource = dataSource
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.reloadData()
    }

}
