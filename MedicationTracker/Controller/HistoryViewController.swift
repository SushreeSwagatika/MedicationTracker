//
//  HistoryViewController.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var allHistory : [History] = []
    
    @IBOutlet var tblHistory: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllHistory()
    }
    
    // MARK:- Private methods
    func fetchAllHistory() {
        DispatchQueue.global().async {
            do {
                self.allHistory = try DataController.shared.fetchAllHistory()
//                debugPrint(self.allHistory)
                DispatchQueue.main.async {
                    self.tblHistory.reloadData()
                }
            } catch {
                
            }
        }
    }
}

// MARK:- UITableViewMethods

extension HistoryViewController: UITableViewMethods {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let history = self.allHistory[indexPath.row]
        if history.hasAlarms?.count == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.allCompleteCellIdentifier.rawValue) as! AllCompleteTableCell
            let mornAlarm = history.hasAlarms?.first(where: {($0 as! Alarm).alarmType == "Morning"}) as! Alarm
            let aftnAlarm = history.hasAlarms?.first(where: {($0 as! Alarm).alarmType == "Afternoon"}) as! Alarm
            let evngAlarm = history.hasAlarms?.first(where: {($0 as! Alarm).alarmType == "Evening"}) as! Alarm
            
            cell.configure(morning: mornAlarm.alarmTime!, afternoon: aftnAlarm.alarmTime!, evening: evngAlarm.alarmTime!, dateString: history.date!)
            return cell
        }
        else if history.hasAlarms?.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.noneCompleteCellIdentifier.rawValue) as! NoneCompleteTableCell
            cell.configure(dateString: history.date!)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.someCompleteCellIdentifier.rawValue) as! SomeCompleteTableCell
        
        var score = 0
        var arrDict = [[String:String]]()
        if let mornAlarm = history.hasAlarms?.first(where: {($0 as! Alarm).alarmType == "Morning"}) as? Alarm {
            var dict = [String:String]()
            dict[mornAlarm.alarmType!] = mornAlarm.alarmTime!
            arrDict.append(dict)
            score = score + 30
        }
        if let aftnAlarm = history.hasAlarms?.first(where: {($0 as! Alarm).alarmType == "Afternoon"}) as? Alarm {
            var dict = [String:String]()
            dict[aftnAlarm.alarmType!] = aftnAlarm.alarmTime!
            arrDict.append(dict)
            score = score + 30
        }
        if let evngAlarm = history.hasAlarms?.first(where: {($0 as! Alarm).alarmType == "Evening"}) as? Alarm {
            var dict = [String:String]()
            dict[evngAlarm.alarmType!] = evngAlarm.alarmTime!
            arrDict.append(dict)
            score = score + 40
        }
//        debugPrint(arrDict)
        cell.configure(array: arrDict, dateString: history.date!, score: String(score))
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.headerCellIdentifier.rawValue) as! HeaderTableCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
}
