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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPedometerData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
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
                    self.todaysSteps.text = "Today: \(data?.numberOfSteps)"
                }
            })
            
        })
        
    }
    
}

