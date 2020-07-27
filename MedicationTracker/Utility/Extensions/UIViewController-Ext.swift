//
//  UIViewController-Ext.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
    func add(_ childVC: UIViewController) {
        addChild(childVC)
        view.addSubview(childVC.view)
        childVC.view.frame = view.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childVC.didMove(toParent: self)
    }
    
    func remove(_ childVC: UIViewController) {
        guard parent != nil else {
            return
        }
        
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }
}
