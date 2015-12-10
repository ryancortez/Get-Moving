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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPedometerData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getPedometerData (){
        
        
        let currentDate = NSDate()
        let startDate = NSDate(timeIntervalSinceNow: -60*60*12)
        
        
        
        pedometer.queryPedometerDataFromDate(startDate, toDate: currentDate, withHandler: {
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
                        self.todaysSteps.text = "\(stepsTaken)"
                    }
                    if let distance = data?.distance{
                        print("distance: \(distance)")
                        let formatter = NSNumberFormatter()
                        formatter.numberStyle = .DecimalStyle
                        formatter.maximumFractionDigits = 1
                        self.todaysDistance.text = formatter.stringFromNumber(distance)
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
                    self.todaysSteps.text = "Today: \(steps)"
                    }
                }
            })
            
        })
        
    }
    
}

