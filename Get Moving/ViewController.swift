//
//  ViewController.swift
//  Get Moving
//
//  Created by Ryan on 12/2/15.
//  Copyright © 2015 Full Screen Ahead. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let pedometer = Pedometer()
        pedometer.getPedometerData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

