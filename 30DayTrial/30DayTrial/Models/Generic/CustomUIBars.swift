//
//  CustomUIBars.swift
//  ThirtyDayTrial
//
//  Created by TørK on 01/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class CustomUIBars {
    

}


class CustomToolBar: UIToolbar {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.barStyle = .default
        self.isTranslucent = true
        self.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        self.sizeToFit()
        self.isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
