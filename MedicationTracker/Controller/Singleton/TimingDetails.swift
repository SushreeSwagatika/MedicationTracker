//
//  TimingDetails.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 25/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import Foundation

class TimingDetails: NSObject {
    
    private let concurrentQueue = DispatchQueue(label: "com.biofourmis.concurrentQueue", attributes: .concurrent)
    private var details:[String:Any] = [:]
    
    private override init() { }
    public static let shared = TimingDetails()
    
    public func setVal(_ value: Any?, forKey key: String) {
        concurrentQueue.async(flags: .barrier) {
            self.details[key] = value
        }
    }
    
    public func val(forKey key: String) -> Any? {
        var result: Any?
        
        concurrentQueue.sync {
            result = details[key]
        }
        return result
    }
    
    public func resetAllValues() {
        details.removeAll()
    }
}
