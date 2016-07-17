//
//  ViewController.swift
//  Get Moving
//
//  Created by Ryan on 12/2/15.
//  Copyright © 2015 Full Screen Ahead. All rights reserved.
//

import UIKit
import CoreMotion



class ViewController: UIViewController {
    
    let pedometer = Pedometer()
    @IBOutlet weak var dailyChartView: DailyChartView!
    @IBOutlet weak var weeklyChartView: WeeklyChartView!
    @IBOutlet weak var hourlyChartView: HourlyChartView!
    @IBOutlet weak var todaysSteps: UILabel!
    @IBOutlet weak var todaysDistance: UILabel!
    @IBOutlet weak var chartSegmentControl: UISegmentedControl!
    var userUsesMetricSystem = false
    var todayStepsTotal = 100
    var countToTodayStepsTotal = 0
    var timer = NSTimer()
    var stepGoal = 6000
    var days:Array<String> = []
    var yValuesForDailyChartView:Array<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        showCorrectChartForSegmentedControl()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.getPedometerDataForToday), name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        getPedometerDataForDailyChartView()
        
        do {
            try refreshUI()
        } catch {
            PedometerDataError.MissingData(dataType: "Missing all data from CMPedometer")
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.updateTodaysStepsInProgress), userInfo: nil, repeats: true)
        
    }
    
    // Mark: Update View
    
    func getPedometerDataForDailyChartView() {
        
        let calendar = NSCalendar.currentCalendar()
        var dates:Array<NSDate> = []
        
        for index in -6 ... 0 {
            dates.insert(calendar.dateByAddingUnit(.Day, value: index, toDate: NSDate(), options: [])!, atIndex: index + 6)
        }
        
        for index in 0 ... 5 {
            pedometer.queryPedometerDataFromDate(dates[index], toDate: dates[index + 1]) { (data, error) in
                
                let numberOfStepsForTheDay = data?.numberOfSteps.integerValue
                self.dailyChartView.yValues.append(numberOfStepsForTheDay!)
                
                if (index == 5) {
                    self.dailyChartView.stepGoal = self.stepGoal
                    
//                    if (self.dailyChartView.yValues == []) {
//                        self.dailyChartView.drawRect(self.dailyChartView.frame)
//                    }
                }
            }
        }
    }


    func getPedometerDataForToday () {
        pedometer.queryPedometerDataFromDate(getBeginningOfTheDay(), toDate: NSDate(), withHandler: {
            data, error in
            
            dispatch_async(dispatch_get_main_queue(), {
                if let pedometerData = data {
                    self.todaysSteps.text = "\(pedometerData.numberOfSteps)"
                    self.todaysDistance.text = "\(round(pedometerData.distance!.floatValue * 0.00062)) miles"
                }
            })
            
            if error != nil {
                print(error.debugDescription)
            }
        })
    }
    
    func updateTodaysStepsInProgress(){
        
        let limitForCount = 30
        
        if (0 < countToTodayStepsTotal && countToTodayStepsTotal < limitForCount){
            todayStepsTotal = todayStepsTotal + 1
            
            dispatch_async(dispatch_get_main_queue(), {
                self.todaysSteps.text = "\(self.todayStepsTotal)"
            })
            countToTodayStepsTotal = countToTodayStepsTotal - 1
            
            if (countToTodayStepsTotal < 0){
                countToTodayStepsTotal = 0
            }
        }
        else{
            getPedometerDataForToday()
        }
    }
    
    func refreshUI() throws {
        
        guard let data = pedometer.data else {
            throw PedometerDataError.MissingData(dataType: "None of the Pedometer Data exists")
        }
        
        todaysSteps.text = "\(data.numberOfSteps)"
        todaysDistance.text = "\(data.distance)"
    }

    // Mark: Helper Functions
    
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
    
    
    // Mark: Segmented Control
    
    func showCorrectChartForSegmentedControl() {
        switch chartSegmentControl.selectedSegmentIndex {
        case 0:
            dailyChartView.hidden = true
            weeklyChartView.hidden = true
            hourlyChartView.hidden = false
        case 1:
            dailyChartView.hidden = false
            weeklyChartView.hidden = true
            hourlyChartView.hidden = true
        case 2:
            dailyChartView.hidden = true
            weeklyChartView.hidden = false
            hourlyChartView.hidden = true
        default: break
        }
    }
    
    @IBAction func chartSegmentChange(sender: AnyObject) {
        switch chartSegmentControl.selectedSegmentIndex {
        case 0:
            dailyChartView.hidden = true
            weeklyChartView.hidden = true
            hourlyChartView.hidden = false
        case 1:
            dailyChartView.hidden = false
            weeklyChartView.hidden = true
            hourlyChartView.hidden = true
        case 2:
            dailyChartView.hidden = true
            weeklyChartView.hidden = false
            hourlyChartView.hidden = true
        default: break
        }
    }
    
    
}

