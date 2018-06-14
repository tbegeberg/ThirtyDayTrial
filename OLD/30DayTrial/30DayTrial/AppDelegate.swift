//
//  AppDelegate.swift
//  30DayTrial
//
//  Created by TørK on 13/02/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BaselistViewControllerDelegate, AppdelegateContext {
    func showSavedTrials(trials: [TrialPeriod]) {
        
    }
    
    func changeState(state: State) {
        self.state = state
        state.enterState(context: self)
    }
    
    
    func showStandardTrials() {
        
    }
    

    var window: UIWindow?
    var mainController = BaseListViewController()
    var state: State?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let notification = LocalNotifier()
        notification.initNotificationSetupCheck()
   
        mainController.appDelegate = self
        mainController.dataSource = TrialTableViewDatasource(trials: mainController.trialArray, editEnabled: true)
        mainController.title = "Trials"
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: mainController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        let trialCancelDateHandler = TrialCancelDateHandler()
        trialCancelDateHandler.findTrialNamesToCancel(trialArray: mainController.trialArray)
        trialCancelDateHandler.showCancelAlerts(controller: mainController)
        TrialHandler.shared.getTrials { trials in
            let state = TrialsLoadedFromSave(trials: trials)
            self.changeState(state: state)
        }
        
        
        return true
    }
    
 
    
    func baseListViewControllerChangeToSearch(sender: BaseListViewController) {
        let searchListViewController = SearchListViewController()
        searchListViewController.title = "Add Standard Trial"
        sender.navigationController?.pushViewController(searchListViewController, animated: true)
    }
    
}

