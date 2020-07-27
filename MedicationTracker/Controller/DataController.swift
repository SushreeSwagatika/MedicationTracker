//
//  DataController.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 26/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataController {
    
    static var shared = DataController()
    
    let persistentContainer = NSPersistentContainer(name: "MedicationTracker")
    
    var context : NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func initStack() {
        self.persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                debugPrint("Could not load store \(error.localizedDescription)")
                return
            }
            debugPrint("Store loaded")
        }
    }
    
    func fetchAllHistory() throws -> [History] {
        let history = try self.context.fetch(History.fetchRequest() as NSFetchRequest<History>)
        return history
    }
    
    func fetchHistory(withHistoryDate date:String) throws -> [History]? {
        let request = NSFetchRequest<History>(entityName: "History")
        request.predicate = NSPredicate(format: "date == %@",date)
        let history = try self.context.fetch(request)
        return history
    }
    
    
    func addNewHistory(alarmTime time: String = "", alarmType type: String = "", isCompleted: Bool = false) throws -> Result<SuccessMessage, FailureError>? {
        let history = History(context: self.context)
        
        history.score = 0
        history.uniqueId = UUID().uuidString
        history.date = Date().getCurrentDateString(withFormat: "dd/MM/yyyy")
        
        if time != "" && type != "" && isCompleted != false {
            let alarm = Alarm(context: self.context)
            alarm.alarmTime = time
            alarm.alarmType = type
            alarm.isCompleted = isCompleted
            
            history.addToHasAlarms(alarm)
        }
        
        do  {
            self.context.insert(history)
            if context.hasChanges {
                try self.context.save()
                return .success(.success200)
            }
        } catch let err {
            print("Saving file resulted in error: ", err)
            return .failure(.coreDataSaveError)
        }
        return nil
    }
    
    
    func updateHistory(withHistoryId id:String , newAlarm:Alarm) throws -> Result<SuccessMessage, FailureError>? {
        let request = NSFetchRequest<History>(entityName: "History")
        request.predicate = NSPredicate(format: "uniqueId == %@",id)
        
        let history = try self.context.fetch(request).first!
        
        let alarm = Alarm(context: self.context)
        alarm.alarmTime = newAlarm.alarmTime
        alarm.alarmType = newAlarm.alarmType
        alarm.isCompleted = newAlarm.isCompleted
        
        history.addToHasAlarms(alarm)
        
        do  {
            if context.hasChanges {
                try self.context.save()
                return .success(.success200)
            }
        } catch let err {
            print("Saving file resulted in error: ", err)
            return .failure(.coreDataSaveError)
        }
        return  nil
    }
}

enum SuccessMessage {
    case success200
}

enum FailureError:Error {
    case coreDataSaveError
}

