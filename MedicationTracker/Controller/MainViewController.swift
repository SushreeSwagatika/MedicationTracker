//
//  MainViewController.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    var datePicker = UIDatePicker()
    
    var dateTextField: UITextField!
    
    @IBOutlet var btnAdd: UIBarButtonItem!
    @IBOutlet var btnList: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataController.shared.initStack()
        
        setupData() // initial data
        
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert(_:)), name: .showAlert, object: nil)
    }
    
    @objc func showAlert(_ notification:Notification) {
        if let data = notification.userInfo as? [String:String] {
            let newType: String = data["type"]! // code
            
            let greet = SupportingTimings.allCases.first(where: { $0.code == newType})?.title
            
            DispatchQueue.main.async {
                self.showAlertType(greet!)
            }
        }
    }
    
    
    // MARK: - private methods
    
    private func setupData() {
        TimingDetails.shared.setVal("11:00", forKey: "Morning")
        self.scheduleAt(hour: 11, minutes: 0, type: "Morning")
        
        TimingDetails.shared.setVal("14:00", forKey: "Afternoon")
        self.scheduleAt(hour: 14, minutes: 0, type: "Afternoon")
        
        TimingDetails.shared.setVal("20:00", forKey: "Evening")
        self.scheduleAt(hour: 20, minutes: 00, type: "Evening")
        
        do {
            if let _ = try DataController.shared.fetchHistory(withHistoryDate: Date().getCurrentDateString(withFormat: "dd/MM/yyyy"))?.first {
                
            } else {
                let _ = try DataController.shared.addNewHistory()
            }
            
        } catch {}
    }
    
    private func showPopover() {
        guard let vc = Storyboard.instantiate(PopoverViewController.self) else {
            fatalError("Could not fetch popoverVC") }
        vc.modalPresentationStyle = .popover
        let popover = vc.popoverPresentationController
        popover?.delegate = self
        popover?.barButtonItem = self.btnAdd
        popover?.sourceRect = CGRect(x: 0, y: 0, width: 120, height: 114)
        popover?.permittedArrowDirections = .up
        
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion:nil)
        }
    }
    
    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        self.dateTextField.text = dateformatter.string(from: self.datePicker.date)
    }
    
    private func showAlertType(_ greet: String) {
        
        let alertController = UIAlertController(title: "Add New \(greet) Timing", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            let screenWidth = UIScreen.main.bounds.width
            self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 220))
            self.datePicker.datePickerMode = .time
            //            self.datePicker.minimumDate = Date()
            self.datePicker.addTarget(self, action: #selector(self.handleDatePicker), for: .valueChanged)
            
            textField.inputView = self.datePicker
            textField.delegate = self
            
            self.dateTextField = textField
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "HH:mm"
            
            switch greet {
            case SupportingTimings.Morning.title:
                let minMornDate = Date().dateAt(hours: 6, minutes: 0)
                let maxMornDate = Date().dateAt(hours: 11, minutes: 59)
                
                if self.datePicker.date >= minMornDate && self.datePicker.date <= maxMornDate {
                    TimingDetails.shared.setVal(dateformatter.string(from: self.datePicker.date), forKey: greet)
                    Utility.showToast(controller: self, message: "Noted.")
                } else {
                    Utility.showToast(controller: self, message: "Please add a valid \(greet) timing.")
                    return
                }
            case SupportingTimings.Afternoon.title:
                let minAftnDate = Date().dateAt(hours: 12, minutes: 0)
                let maxAftnDate = Date().dateAt(hours: 17, minutes: 59)
                
                if self.datePicker.date >= minAftnDate && self.datePicker.date <= maxAftnDate {
                    TimingDetails.shared.setVal(dateformatter.string(from: self.datePicker.date), forKey: greet)
                    Utility.showToast(controller: self, message: "Noted.")
                } else {
                    Utility.showToast(controller: self, message: "Please add a valid \(greet) timing.")
                    return
                }
            case SupportingTimings.Evening.title:
                let minEvngDate = Date().dateAt(hours: 18, minutes: 0)
                let maxEvngDate = Date().dateAt(hours: 23, minutes: 59)
                
                if self.datePicker.date >= minEvngDate && self.datePicker.date <= maxEvngDate {
                    TimingDetails.shared.setVal(dateformatter.string(from: self.datePicker.date), forKey: greet)
                    Utility.showToast(controller: self, message: "Noted.")
                } else {
                    Utility.showToast(controller: self, message: "Please add a valid \(greet) timing.")
                    return
                }
            default:
                fatalError("")
            }
            
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: self.datePicker.date)
            let minutes = calendar.component(.minute, from: self.datePicker.date)
            self.scheduleAt(hour: hour, minutes: minutes, type: greet)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    private func scheduleAt(hour: Int?, minutes: Int?, type: String) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let notification = UNMutableNotificationContent()
        notification.title = "Take Medicine"
        notification.body = "You have to take your \(type.lowercased()) medicine."
        notification.categoryIdentifier = "alarm"
        notification.userInfo = ["time": "\(String(describing: hour)):\(String(describing: minutes))", "type": type]
        notification.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour!
        dateComponents.minute = minutes!
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notification, trigger: trigger)
        
        let actionButton = UNNotificationAction(identifier: "TakeMedicineAction", title: "Medicine taken", options: .foreground)
        let notificationCategory = UNNotificationCategory(identifier: "alarm", actions: [actionButton], intentIdentifiers: [])
        center.setNotificationCategories([notificationCategory])
        
        center.add(request)
    }
    
    @IBAction func addNewCalendarTiming(_ sender: Any) {
        var granted = false
        
        DispatchQueue.global().async {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                if settings.alertSetting == .enabled {
                    granted = true
                    DispatchQueue.main.async {
                        if granted {
                            self.showPopover()
                        }
                        else {
                            Utility.showToast(controller: self, message: "Please grant permission to access calendar.")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        Utility.showToast(controller: self, message: "Please grant permission to access calendar.")
                    }
                }
            }
        }
    }
    
    @IBAction func showTimingsList(_ sender: Any) {
        let showVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ListViewController") as! ListViewController
        showVC.modalPresentationStyle = .automatic
        self.present(showVC, animated: true, completion: nil)
    }
    
}




// MARK: - UIPopoverPresentationControllerDelegate
extension MainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}


// MARK: -
extension MainViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        completionHandler( [.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        guard let time = userInfo["time"] as? String, let type = userInfo["type"] as? String else {
            return
        }
        
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            debugPrint("Message tapped")
            
        case "TakeMedicineAction":
            debugPrint("User tapped on Take medicine button")
            
            DispatchQueue.global().async {
                do {
                    let alarm = Alarm(context: DataController.shared.context)
                    alarm.alarmType = type
                    alarm.alarmTime = time
                    alarm.isCompleted = true
                    
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
                        let result = try DataController.shared.addNewHistory(alarmTime: time, alarmType: type, isCompleted: true)
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
                } catch {}
            }
            
            break
            
        default:
            break
        }
        
        completionHandler()
    }
}
