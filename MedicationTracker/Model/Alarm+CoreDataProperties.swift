//
//  Alarm+CoreDataProperties.swift
//  
//
//  Created by Sushree Swagatika on 26/07/20.
//
//

import Foundation
import CoreData


extension Alarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarm> {
        return NSFetchRequest<Alarm>(entityName: "Alarm")
    }

    @NSManaged public var alarmType: String?
    @NSManaged public var alarmTime: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var ofHistory: History?

}
