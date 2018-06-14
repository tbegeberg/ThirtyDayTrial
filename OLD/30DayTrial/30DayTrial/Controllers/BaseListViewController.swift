//
//  BaseListViewController.swift
//  ThirtyDayTrial
//
//  Created by TørK on 28/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

protocol BaselistViewControllerDelegate:class {
    func baseListViewControllerChangeToSearch(sender:BaseListViewController)
}

class BaseListViewController: UITableViewController {
    
    var trialArray = [TrialPeriod]()
    var dataSource: UITableViewDataSource?
    weak var appDelegate: BaselistViewControllerDelegate?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.tableView.dataSource = self.dataSource
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToSearchView))
        self.navigationItem.setRightBarButton(item, animated: true)
        self.tableView.reloadData()
    }
    
    @ objc func goToSearchView() {
        self.appDelegate?.baseListViewControllerChangeToSearch(sender: self)
    }
}
