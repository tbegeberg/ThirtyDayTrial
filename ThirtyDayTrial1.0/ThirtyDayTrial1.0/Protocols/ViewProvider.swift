//
//  ViewProvicer.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 08/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//


import UIKit

protocol ViewProvider {
    func getViewController() -> UIViewController
}

extension UIViewController:ViewProvider {
    func getViewController() -> UIViewController {
        return self
    }
}
