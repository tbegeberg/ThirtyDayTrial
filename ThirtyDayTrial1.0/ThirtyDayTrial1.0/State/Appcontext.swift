//
//  Appcontext.swift
//  ThirtyDayTrial
//
//  Created by TørK on 06/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

protocol AppContext: ListViewResponder {
    var state:State? { get set }
    func present(view: ViewProvider)
    func changeState(state: State)
}

extension ItemClickedResponder where Self:AppContext {
    func itemClicked(item: TrialPeriod, sender: BaseListViewController) {
        self.state?.selectedItemFromList(context: self, item: item, sender: sender)
    }
    func itemSwiped(item: Listable) {
        self.state?.swipedItemFromList(context: self, item: item)
    }
}
