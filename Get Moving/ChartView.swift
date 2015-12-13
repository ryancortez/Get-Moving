//
//  ChartView.swift
//  Get Moving
//
//  Created by Ryan on 12/11/15.
//  Copyright © 2015 Full Screen Ahead. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class ChartView: UIView {
    
    override func drawRect(rect: CGRect) {
        //set up the width and height variables
        //for the horizontal stroke
        let plusHeight: CGFloat = 2.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 2.0
        
        //create the path
        let plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 - plusWidth/2,
            y:bounds.height/2))
        
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth/2,
            y:bounds.height/2))
        
        //set the stroke color
        UIColor.blueColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
    }
}