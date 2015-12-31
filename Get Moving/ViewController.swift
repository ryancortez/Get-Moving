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
    var todayStepsTotal = NSNumber()
    var countToTodayStepsTotal = 0
    var timer = NSTimer()
    
    override func viewDidAppear(animated: Bool){
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("getPedometerData"), name: UIApplicationDidBecomeActiveNotification, object: nil)
        getPedometerData()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateTodaysSteps"), userInfo: nil, repeats: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func chartSegmentChange(sender: AnyObject) {
        
    }
    
    
    func getPedometerData (){
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: NSDate())
        components.hour = 0
        components.minute = 0
        components.second = 0
        let timeZone = NSTimeZone.systemTimeZone()
        calendar.timeZone = timeZone
        let beginningOfToday = calendar.dateFromComponents(components)!
        
        pedometer.queryPedometerDataFromDate(beginningOfToday, toDate: currentDate, withHandler: {
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
                        self.todayStepsTotal = stepsTaken
                        
                        dispatch_async(dispatch_get_main_queue(), {
                        self.todaysSteps.text = "\(self.todayStepsTotal)"
                        })
                    }
                    if var distance = data?.distance{
                        print("distance: \(distance)")
                        let formatter = NSNumberFormatter()
                        formatter.numberStyle = .DecimalStyle
                        formatter.maximumFractionDigits = 1
                        
                        if (self.userUsesMetricSystem == true){
                            distance = distance.floatValue / 1000
                            dispatch_async(dispatch_get_main_queue(), {
                            self.todaysDistance.text = formatter.stringFromNumber(distance)! + " km"
                            })
                        }
                        else{
                            distance = distance.floatValue * 0.00062137
                            dispatch_async(dispatch_get_main_queue(), {
                            self.todaysDistance.text = formatter.stringFromNumber(distance)! + " miles"
                            })
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
            if let steps = data?.numberOfSteps {
                if(error == nil){
                    self.countToTodayStepsTotal = self.countToTodayStepsTotal + steps.integerValue
                }
            }
        })
    }
    
    func updateTodaysSteps(){
        
        let limitForCount = 30
        
        if (0 < countToTodayStepsTotal && countToTodayStepsTotal < limitForCount){
            todayStepsTotal = todayStepsTotal.integerValue + 1
            
            dispatch_async(dispatch_get_main_queue(), {
                self.todaysSteps.text = "\(self.todayStepsTotal)"
            })
            countToTodayStepsTotal = countToTodayStepsTotal - 1
            
            if (countToTodayStepsTotal < 0){
                countToTodayStepsTotal = 0
            }
        }
        else{
            getPedometerData()
        }
    }
    
}

