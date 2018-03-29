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
    let notification = LocalNotifier()
    let mainController = BaseListViewController()
    var trialsCancelArray = [String]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        notification.initNotificationSetupCheck()
        loadTrials()
        mainController.dataSource  = TrialTableViewDatasource(trials: mainController.trialArray, editEnabled: true)
        window = UIWindow(frame: UIScreen.main.bounds)
        mainController.view.backgroundColor = UIColor.white
        let navigationController = UINavigationController(rootViewController: mainController)
        navigationController.navigationBar.isTranslucent = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        findTrialsToCancel()
        showCancelAlerts()
        return true
    }
    
    func loadTrials() {
        TrialHandler.shared.getTrials { trial in
            self.mainController.trialArray.append(trial)
        }
    }
    
    func showCancelAlerts() {
        if let trialToCancel = self.trialsCancelArray.first {
            AudioServicesPlayAlertSound(SystemSoundID(1322))
            let alert = UIAlertController(title: "Alert", message: "Time To Cancel Trial: \(trialToCancel)", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default) { action in
                self.trialsCancelArray.remove(at: 0)
                self.showCancelAlerts()
            }
            alert.addAction(okayAction)
            mainController.present(alert, animated: true, completion: nil)
        }
    }
    
    func findTrialsToCancel() {
        let trialCancelDateHandler = TrialCancelDateHandler()
        self.trialsCancelArray = trialCancelDateHandler.findTrialNamesToCancel(trialArray: mainController.trialArray)
    }

}

