//
//  DailyChartView.swift
//  Get Moving
//
//  Created by Ryan on 12/11/15.
//  Copyright © 2015 Full Screen Ahead. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

class DailyChartView: ChartView {
    
    var pedometer: CMPedometer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.pedometer = CMPedometer()
        
    }
    
    func getDayOfWeek()->Int {
        
        let todayDate:NSDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let myComponents = myCalendar?.components(NSCalendarUnit.Weekday, fromDate: todayDate)
        let weekDay = myComponents?.weekday
        
        return weekDay!
    }

}