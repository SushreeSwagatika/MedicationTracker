//
//  History+CoreDataProperties.swift
//  
//
//  Created by Sushree Swagatika on 26/07/20.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var score: Int16
    @NSManaged public var date: String?
    @NSManaged public var uniqueId: String?
    @NSManaged public var hasAlarms: NSSet?

}

// MARK: Generated accessors for hasAlarms
extension History {

    @objc(addHasAlarmsObject:)
    @NSManaged public func addToHasAlarms(_ value: Alarm)

    @objc(removeHasAlarmsObject:)
    @NSManaged public func removeFromHasAlarms(_ value: Alarm)

    @objc(addHasAlarms:)
    @NSManaged public func addToHasAlarms(_ values: NSSet)

    @objc(removeHasAlarms:)
    @NSManaged public func removeFromHasAlarms(_ values: NSSet)

}
