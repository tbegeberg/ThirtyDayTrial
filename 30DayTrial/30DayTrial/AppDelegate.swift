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
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let mainController = BaseListViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let notification = LocalNotifier() //Placer here??
        notification.initNotificationSetupCheck()
        loadTrials()
        mainController.dataSource  = TrialTableViewDatasource(trials: mainController.trialArray, editEnabled: true)
        window = UIWindow(frame: UIScreen.main.bounds)
        mainController.view.backgroundColor = UIColor.white
        let navigationController = UINavigationController(rootViewController: mainController)
        navigationController.navigationBar.isTranslucent = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        let trialCancelDateHandler = TrialCancelDateHandler()
        trialCancelDateHandler.findTrialNamesToCancel(trialArray: mainController.trialArray)
        trialCancelDateHandler.showCancelAlerts(controller: mainController)
        return true
    }
    
    func loadTrials() {
        TrialHandler.shared.getTrials { trial in
            self.mainController.trialArray.append(trial)
        }
    }
    
}

