//
//  ListViewController.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 24/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var dictList = [String:String]()
    var arrKeys = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        
        Utility.showToast(controller: self, message: "Swipe left to complete your action.")
    }
    

    // MARK: - Private methods
    
    private func setupData() {
        for item in SupportingTimings.allCases {
            let key = item.title
            debugPrint(key)
            
            if let value = TimingDetails.shared.val(forKey: key) as? String {
                debugPrint(value)
                dictList[key] = value
                self.arrKeys.append(key)
            }
        }
        debugPrint(dictList)
        debugPrint(self.arrKeys)
    }

}

// MARK: -  UITableViewMethods

extension ListViewController: UITableViewMethods {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.listCellIdentifier.rawValue)!
        
        let key = self.arrKeys[indexPath.row]
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = self.dictList[key]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Medication Timings"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(
            style: .normal,
            title: "Taken",
            handler: { (action, view, completion) in
                
                let type = self.arrKeys[indexPath.row]
                
                let time = self.dictList[type]
                let hours = Int((time?.components(separatedBy: ":").first)!)!
                let minutes = Int((time?.components(separatedBy: ":").last)!)!
                
                let now = Date()
                let setDate = Date().dateAt(hours: hours, minutes: minutes)
                if now < setDate {
                    Utility.showToast(controller: self, message: "Current time exceeding Set time.")
                }
                else {
                    let alarm = Alarm(context: DataController.shared.context)
                    alarm.alarmType = type
                    alarm.alarmTime = time
                    alarm.isCompleted = true
                    
                    do {
                        if let history = try DataController.shared.fetchHistory(withHistoryDate: Date().getCurrentDateString(withFormat: "dd/MM/yyyy"))?.first {
                            let result = try DataController.shared.updateHistory(withHistoryId: history.uniqueId!, newAlarm: alarm)
                            switch result{
                            case .success(let message):
                                debugPrint(message)
                            case .failure(let error):
                                debugPrint(error)
                            case .none:
                                debugPrint("")
                            }
                        } else {
                            let result = try DataController.shared.addNewHistory(alarmTime: time!, alarmType: type, isCompleted: true)
                            switch result
                            {
                            case .success(let message):
                                debugPrint(message)
                            case .failure(let error):
                                debugPrint(error)
                            case .none:
                                debugPrint("")
                            }
                        }
                    } catch{}
                }
                completion(true)
        })
        
        action.backgroundColor = UIColor(named: "greenMedicationColor")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
