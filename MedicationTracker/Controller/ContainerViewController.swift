//
//  ContainerViewController.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

typealias UITableViewMethods = UITableViewDataSource & UITableViewDelegate

class ContainerViewController: UIViewController {

    var currentTabType = TabItemType.Score
        
    private lazy var scoreViewController: ScoreViewController = {
        guard let vc = Storyboard.instantiate(ScoreViewController.self) else { fatalError("Could not fetch scoreViewController")}
        self.add(vc)
        return vc
    }()
    private lazy var historyViewController: HistoryViewController = {
        guard let vc = Storyboard.instantiate(HistoryViewController.self) else { fatalError("Could not fetch historyViewController")}
        self.add(vc)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .background).async {
            let center = UNUserNotificationCenter.current()

            center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceive(_:)), name: .changeVC, object: nil)
        self.updateView(type: currentTabType)
    }
    
    @objc func onDidReceive(_ notification:Notification) {
        if let data = notification.userInfo as? [String:TabItemType] {
            currentTabType = data["type"]!
            self.updateView(type: currentTabType)
        }
    }
    
    
    // MARK:- Private methods
    
    private func updateView(type:TabItemType) {
        self.currentTabType = type
        switch type {
        case .Score:
            self.remove(historyViewController)
            self.add(scoreViewController)
        case .History:
            self.remove(scoreViewController)
            self.add(historyViewController)
        default:
            fatalError("VC is not in list")
        }
    }
}
