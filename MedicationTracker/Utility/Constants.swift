//
//  Constants.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import Foundation
import UIKit

public enum Storyboard: String {
    case Score
    case History
    
    static func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard
            .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
            else {
                fatalError("Couldn't instantiate \(VC.storyboardIdentifier)") }
        return vc
    }
}

enum CellIdentifier: String {
    
    // history screen
    case headerCellIdentifier = "headerCell"
    case allCompleteCellIdentifier = "allCompleteCell"
    case someCompleteCellIdentifier = "someCompleteCell"
    case noneCompleteCellIdentifier = "noneCompleteCell"
    
    // list screen
    case listCellIdentifier = "listCell"
    
    // dropdown
    case DropdownCellIdentifier = "dropdownCell"
}

enum TabItemType: String, CaseIterable {
    case Score, History
}

enum SupportingTimings: NumberingValue, CaseIterable {
    case Morning = "Morning,MORN,0", Afternoon = "Afternoon,AFTN,1", Evening = "Evening,EVNG,2"
    
    var title: String { return rawValue.title }
    var code: String { return rawValue.code }
    var index: Int {return rawValue.index}
}
