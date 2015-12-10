//
//  ViewController.swift
//  Get Moving
//
//  Created by Ryan on 12/2/15.
//  Copyright © 2015 Full Screen Ahead. All rights reserved.
//

import UIKit
import CoreMotion

let pedometer = CMPedometer()


class ViewController: UIViewController {
    
    @IBOutlet weak var todaysSteps: UILabel!
    @IBOutlet weak var todaysDistance: UILabel!
    var userUsesMetricSystem = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPedometerData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getPedometerData (){
        
        var todayStepsTotal = NSNumber()
        
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: NSDate())
        components.hour = 0
        components.minute = 0
        components.second = 0
        let timeZone = NSTimeZone.systemTimeZone()
        calendar.timeZone = timeZone
        
        let theBeginningOfToday = calendar.dateFromComponents(components)!
        
        
        
        pedometer.queryPedometerDataFromDate(theBeginningOfToday, toDate: currentDate, withHandler: {
            data, error in
            
            if (error == nil) {
                if (data != nil) {
                    
                    if let startDate = data?.startDate{
                        print("startDate: \(startDate)")
                    }
                    if let endDate = data?.startDate{
                        print("endDate: \(endDate)")
                    }
                    if let stepsTaken = data?.numberOfSteps{
                        print("stepsTaken: \(stepsTaken)")
                        todayStepsTotal = stepsTaken
                        self.todaysSteps.text = "\(todayStepsTotal)"
                    }
                    if var distance = data?.distance{
                        print("distance: \(distance)")
                        let formatter = NSNumberFormatter()
                        formatter.numberStyle = .DecimalStyle
                        formatter.maximumFractionDigits = 1
                        
                        if (self.userUsesMetricSystem == true){
                            distance = distance.floatValue / 1000
                            self.todaysDistance.text = formatter.stringFromNumber(distance)! + " km"
                        }
                        else{
                            distance = distance.floatValue * 0.00062137
                            self.todaysDistance.text = formatter.stringFromNumber(distance)! + " miles"
                        }
                        
                    }
                    if let currentCadence = data?.currentCadence{
                        print("currentCadence: \(currentCadence)")
                    }
                    if let currentPace = data?.currentPace{
                        print("currentPace: \(currentPace)")
                    }
                    if let floorsAscended = data?.floorsAscended{
                        print("floorsAscended: \(floorsAscended)")
                    }
                    if let floorsDescended = data?.floorsDescended{
                        print("floorsDescended: \(floorsDescended)")
                    }
                }
            }
            else{
                print("There was an error retrieving the pedometer data: \(error.debugDescription)")
            }
        })
        
        pedometer.startPedometerUpdatesFromDate(currentDate, withHandler: {data, error in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if(error == nil){
                    
                    if let steps = data?.numberOfSteps {
                    
                    todayStepsTotal = todayStepsTotal.floatValue + steps.floatValue
                    self.todaysSteps.text = "\(todayStepsTotal)"
                    }
                }
            })
            
        })
        
    }
    
}

