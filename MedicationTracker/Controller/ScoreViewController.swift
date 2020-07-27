//
//  ScoreViewController.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet var viewback: UIView!
    
    @IBOutlet var lblGreeting: UILabel!
    @IBOutlet var lblScorevalue: UILabel!
    @IBOutlet var btnMedicationTaken: UIButton!
    
    var isTaken = false
    var score = 0
    var greeting = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        score = 0
        do {
            if let history = try DataController.shared.fetchHistory(withHistoryDate: Date().getCurrentDateString(withFormat: "dd/MM/yyyy"))?.first {
                for eachAlarm in history.hasAlarms! {
                    if (eachAlarm as! Alarm).alarmType == "Evening" {
                        score = score + 40
                    } else {
                        score = score + 30
                    }
                }
            }
        } catch{}
        
        setupView()
    }
    
    // MARK:- Private methods
    
    private func setupView() {
        lblScorevalue.text = String(score)
        
        if score == 100 {
            lblScorevalue.textColor = UIColor(named: "greenMedicationColor")
        } else if score <= 30 {
            lblScorevalue.textColor = UIColor(named: "redMedicationColor")
        } else {
            lblScorevalue.textColor = UIColor(named: "yellowMedicationColor")
        }
        
        getGreetingText()
        
        self.viewback.setCustomBorder()
        self.btnMedicationTaken.corner()
    }
    
    private func getGreetingText() {
        let now = Date()
        
        let minMornDate = Date().dateAt(hours: 6, minutes: 0)
        let maxMornDate = Date().dateAt(hours: 11, minutes: 59)
        
        let minAftnDate = Date().dateAt(hours: 12, minutes: 0)
        let maxAftnDate = Date().dateAt(hours: 17, minutes: 59)
        
        let minEvngDate = Date().dateAt(hours: 18, minutes: 0)
        let maxEvngDate = Date().dateAt(hours: 23, minutes: 59)
                
        if now >= minMornDate && now <= maxMornDate {
            lblGreeting.text = "Good Morning"
        } else if now >= minAftnDate && now <= maxAftnDate {
            lblGreeting.text = "Good Afternoon"
        } else if now >= minEvngDate && now <= maxEvngDate {
            lblGreeting.text = "Good Evening"
        } else {
            lblGreeting.text = "Get some sleep"
        }
    }
    
    // MARK:- Button Actions

    @IBAction func didTakeMedication(_ sender: Any) {
        DispatchQueue.main.async {
            let showVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ListViewController") as! ListViewController
            showVC.modalPresentationStyle = .automatic
            self.present(showVC, animated: true, completion: nil)            
        }
    }
}
