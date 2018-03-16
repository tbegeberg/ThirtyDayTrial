//
//  StandardTrialViewController.swift
//  ThirtyDayTrial
//
//  Created by TørK on 16/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit

class StandardTrialViewController: UIViewController {

    //Add standard by search
    //Add listview for search
    //Array with all standard trisl
    
    var standardTrails: [TrialPeriod] = [TrialPeriod(trialName: "Netflix", startDate: Date(), endDate: 30, cancellationTime: Date.distantFuture), TrialPeriod(trialName: "Amazon", startDate: Date(), endDate: 20, cancellationTime: Date.distantFuture)]
    let trialSearchBar = CustomSearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(trialSearchBar)
        trialSearchBar.placeholder = "Enter a Trial Name"
        trialSearchBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(80)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(self.view.frame.height/5)
        }
        
        
    }





}
