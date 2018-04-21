//
//  CustomUIControls.swift
//  ThirtyDayTrial
//
//  Created by TørK on 01/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit


class UIBarButtonItemActionable:UIBarButtonItem {
    var actionBlock:(()->())?
    
    init(title: String) {
        super.init()
        self.title = title
        self.target = self
        self.style = .plain
        self.action = #selector(theSelector(sender:))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func theSelector(sender:UIBarButtonItem) {
        self.actionBlock?()
    }
}








