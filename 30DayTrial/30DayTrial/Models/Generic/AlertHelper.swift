//
//  AlertHelper.swift
//  ThirtyDayTrial
//
//  Created by TørK on 21/02/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AlertHelper {
    
    func showErrorAlert(fromController controller: UIViewController, error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showSuccessSave(fromController controller: UIViewController) {
        let alert = UIAlertController(title: "Success", message: "Trial has been saved", preferredStyle: UIAlertControllerStyle.alert)
        let goToList = UIAlertAction(title: "Ok", style: .default, handler: { action in
            controller.performSegue(withIdentifier: "Back", sender: controller)
        }
        )
        alert.addAction(goToList)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func timeToCancel(fromController controller: UIViewController) {
        AudioServicesPlayAlertSound(SystemSoundID(1322))
        let alert = UIAlertController(title: "Alert", message: "Time To Cancel Trial", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        controller.present(alert, animated: true, completion: nil)
        
    }
    
   
    
}




