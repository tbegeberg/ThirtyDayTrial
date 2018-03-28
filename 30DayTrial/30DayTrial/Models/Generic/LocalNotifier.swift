//
//  LocalNotice.swift
//  ThirtyDayTrial
//
//  Created by TørK on 28/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotifier: UNMutableNotificationContent {

    func initNotificationSetupCheck() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert])
        { (success, error) in
            if success {
                print("Permission Granted")
            } else {
                print("There was a problem!")
            }
        }
    }
    
    func addLocalNotification(notification: UNMutableNotificationContent, timeToCancelMinusOneDay: Double) {
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeToCancelMinusOneDay, repeats: false)
        let request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
}
