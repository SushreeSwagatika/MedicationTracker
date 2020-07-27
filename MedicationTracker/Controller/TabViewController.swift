//
//  TabViewController.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {
    
    @IBOutlet var imgVewScore: UIImageView!
    @IBOutlet var lblScore: UILabel!
    
    @IBOutlet var imgVewHistory: UIImageView!
    @IBOutlet var lblHistory: UILabel!
    
    private var selectedType = TabItemType.Score
    
    let pointSizeNormal = CGFloat(17.0)
    var sizeOriginal: CGSize = CGSize(width: 28, height: 28)
    let scalePoint: CGFloat = 1.1

    override func viewDidLoad() {
        super.viewDidLoad()

        scale()
        setupView()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        self.view.roundTopCorners(corners: [.topLeft, .topRight], radius: 20.0)
    }
    
    private func scale() {
        self.setToNormal(pointSize: pointSizeNormal)
        switch selectedType {
        case .Score:
            self.imgVewScore.contentMode = .scaleAspectFill
            self.imgVewScore.tintColor = UIColor.systemOrange
            self.lblScore.textColor = UIColor.systemOrange
            self.lblScore.font = UIFont.systemFont(ofSize: pointSizeNormal + scalePoint)
        case .History:
            self.imgVewHistory.contentMode = .scaleAspectFill
            self.imgVewHistory.tintColor = UIColor.systemOrange
            self.lblHistory.textColor = UIColor.systemOrange
            self.lblHistory.font = UIFont.systemFont(ofSize: pointSizeNormal + scalePoint)
        default:
            fatalError("Type not in the list")
        }
    }
    
    private func setToNormal(pointSize: CGFloat) {
        self.imgVewScore.contentMode = .scaleAspectFit
        self.imgVewScore.tintColor = UIColor.white
        self.lblScore.textColor = UIColor.white
        self.lblScore.font = UIFont.systemFont(ofSize: pointSize)
        
        self.imgVewHistory.contentMode = .scaleAspectFit
        self.imgVewHistory.tintColor = UIColor.white
        self.lblHistory.textColor = UIColor.white
        self.lblHistory.font = UIFont.systemFont(ofSize: pointSize)
    }
    
    // MARK: - Button Action
    
    @IBAction func onTapScore(_ sender: Any) {
        selectedType = TabItemType.Score
        scale()
        NotificationCenter.default.post(name: .changeVC, object: self, userInfo: ["type":TabItemType.Score])
    }
    
    @IBAction func onTapHistory(_ sender: Any) {
        selectedType = TabItemType.History
        scale()
        NotificationCenter.default.post(name: .changeVC, object: self, userInfo: ["type":TabItemType.History])
    }

}
