 //
//  PedometerData.swift
//  Get Moving
//
//  Created by Ryan on 3/24/16.
//  Copyright © 2016 Full Screen Ahead. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit

func getBeginningOfTheDay () -> NSDate {
    
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: NSDate())
    let timeZone = NSTimeZone.systemTimeZone()
    
    components.hour = 0
    components.minute = 0
    components.second = 0
    calendar.timeZone = timeZone
    
    return calendar.dateFromComponents(components)!
}

func getCurrentDate() -> NSDate {
    return NSDate()
}



enum DistanceUnit: Float {
    
    // CMPedometer data is currently measured in meters, below are values that are multiplied to convert from meters to something else
    
    case Meters = 1
    case Kilometers = 1000
    case Miles = 0.00062137
}


// Errors that could be thrown when attempting to pull CMPedometer data
enum PedometerDataError: ErrorType {
    case MissingData(dataType: String)
}

class Pedometer: CMPedometer {
    
    override init() {
        super.init()
        self.data = nil
    }
    
    var data: CMPedometerData?
    var numberOfStepsArray: Array<Int> = []

    
    func getPedometerData (fromDate fromDate: NSDate, toDate: NSDate) -> CMPedometerData? {
        
        self.queryPedometerDataFromDate(fromDate, toDate: toDate, withHandler: {
            data, error in
            
            if let pedometerData = data {
                self.data = pedometerData
            }
            
            if error != nil {
                print(error.debugDescription)
            }
        })
        
        return self.data
    }
    
    func pullPastWeekPedometerData() {
        
        let calendar = NSCalendar.currentCalendar()
        var dates:Array<NSDate> = []
        
        for index in -6 ... 0 {
            dates.insert(calendar.dateByAddingUnit(.Day, value: index, toDate: NSDate(), options: [])!, atIndex: index + 6)
        }
        
        
        for index in 0 ... 5 {
            
            self.queryPedometerDataFromDate(dates[index], toDate: dates[index + 1]) { (data, error) in

                    let numberOfSteps = data?.numberOfSteps.integerValue
                    self.saveDataFromPedometerInArray(numberOfSteps!)
                
                if (index == 5) {

                }
            }
        }
    }
    
    func saveDataFromPedometerInArray(numberOfSteps: Int) {
        numberOfStepsArray.append(numberOfSteps)
    }
}
 




