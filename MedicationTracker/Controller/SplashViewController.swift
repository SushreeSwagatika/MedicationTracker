//
//  SplashViewController.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestures()
        
        Utility.showToast(controller: self, message: "Swipe left to move forward.")
    }


    // MARK:- Private methods
    
    private func loadContainerScreen() {
        DispatchQueue.main.async {
            guard let vc = Storyboard.instantiate(MainNavController.self) else {
            fatalError("Could not fetch MainNavController") }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    private func addGestures() {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipeGesture(_:)))
        leftSwipeGesture.direction = .left
        self.view.addGestureRecognizer(leftSwipeGesture)
    }
    
    @objc func handleLeftSwipeGesture(_ leftSwipeGestureRecognizer:UISwipeGestureRecognizer) {
        loadContainerScreen()
    }
}

