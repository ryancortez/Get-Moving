//
//  CaptureMotion.swift
//  Get Moving
//
//  Created by Ryan on 12/2/15.
//  Copyright © 2015 Full Screen Ahead. All rights reserved.
//

import Foundation
import CoreMotion

// NEXT STEPS

// Follow information in URL https://developer.apple.com/library/ios/documentation/CoreMotion/Reference/CoreMotion_Reference/ under Pedometer

// 1. Read the documentation
let pedometer = CMPedometer()

class Pedometer {
    
    var stepsTaken = NSNumber(int: 0)
    
    func getPedometerData (){
        
        
        let currentDate = NSDate()
        let startDate = NSDate(timeIntervalSinceNow: -60*60*12)
        
        
        
        pedometer.queryPedometerDataFromDate(startDate, toDate: currentDate, withHandler: {
            data, error in
            
            if (error == nil) {
                if (data != nil) {
                    self.stepsTaken = (data?.numberOfSteps)!
                    
                    print("stepsTaken: \(self.stepsTaken)")
                    print("startDate: \(data?.startDate)")
                    print("endDate: \(data?.endDate)")
                    print("distance: \(data?.distance)")
                    print("currentCadence: \(data?.currentCadence)")
                    print("currentPace: \(data?.currentPace)")
                    print("floorsAscended: \(data?.floorsAscended)")
                    print("floorsDescended: \(data?.floorsDescended)")
                }
            }
            else{
                print("There was an error retrieving the pedometer data: \(error.debugDescription)")
            }
        })
        
        pedometer.startPedometerUpdatesFromDate(currentDate, withHandler: {data, error in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if(error == nil){
                    
                }
            })
            
        })
        
    }
}