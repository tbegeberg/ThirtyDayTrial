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

class AlertHandler {
    
    func showErrorAlert(fromController controller: UIViewController, error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showSuccessSave(fromController controller: UIViewController, message: String) {
        let alert = UIAlertController(title: "Success", message: "Trial:\(message) was saved", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(fromController controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        controller.present(alert, animated: true, completion: nil)
    }

    
}




