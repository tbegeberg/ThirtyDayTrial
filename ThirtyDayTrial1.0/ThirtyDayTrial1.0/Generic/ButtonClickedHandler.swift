//
//  ButtonClickedHandler.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 10/05/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

enum ResultButtonClicked {
    case success(Trial)
    case error(String)
}


class ButtonClickedHandler {
    
    private func saveButtonClicked(item: Trial, completionHandler: @escaping (ResultButtonClicked)->()) {
        do {
            try TrialHandler.shared.saveTrialOnDevice(trial: item)
            completionHandler(ResultButtonClicked.success(item))
        }
        catch TrialError.NoTimeInterval(let error) {
            completionHandler(ResultButtonClicked.error(error))
        }
        catch let error {
            completionHandler(ResultButtonClicked.error(error.localizedDescription))
        }
    }
   
    func feedback(item: Trial) -> (String, String) {
        var title = String()
        var message = String()
        self.saveButtonClicked(item: item) { (result:ResultButtonClicked) in
            switch result {
            case .success(let value):
                title = "Success"
                message = "Trial: \(value.trialName) was saved"
            case .error(let error):
                title = "Error"
                message = error
            }
        }
        return (title, message)
    }
    
    
   
    
    
    
}
