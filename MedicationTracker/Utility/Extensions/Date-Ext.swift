//
//  Date-Ext.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 25/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func dateAt(hours: Int, minutes: Int) -> Date {
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        var date_components = calendar.components([NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day], from: self)
        date_components.hour = hours
        date_components.minute = minutes
        date_components.second = 0
        
        let newDate = calendar.date(from: date_components)!
        
        return newDate
    }
    
    func getCurrentDateString(withFormat format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        let formattedDate = formatter.string(from: Date())
        
        return formattedDate
    }
}
