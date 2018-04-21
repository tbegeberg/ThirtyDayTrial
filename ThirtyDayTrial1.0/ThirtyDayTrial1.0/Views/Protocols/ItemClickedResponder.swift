//
//  ItemClickedResponder.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 11/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation

protocol ItemClickedResponder {
    func itemClicked(item: TrialPeriod, sender: BaseListViewController)
    func itemSwiped(item: Listable)
}
