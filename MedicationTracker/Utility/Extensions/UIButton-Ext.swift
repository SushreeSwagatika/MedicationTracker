//
//  UIButton-Ext.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func corner() {
        self.layer.cornerRadius = self.frame.size.height / 4
        self.clipsToBounds = true
    }
}
