//
//  AppDelegate.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 07/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppContext {
  
    var window: UIWindow?
    var state: State?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let notification = LocalNotifier()
        notification.initNotificationSetupCheck()
        setupWindow()
        self.changeState(state: TrialsLoadedFromSave())
        return true
    }
    
    func present(view: ViewProvider) {
        self.setRootViewController(viewController: view.getViewController())
    }
    
    func changeState(state: State) {
        print("Entering: \(state)")
        self.state = state
        state.enterState(context: self)
    }
    
    func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func setRootViewController(viewController:UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = navigationController
    }
    

}

