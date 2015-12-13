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
        
        // Number of columns wanted in the line chart
        let numberOfColumns = 7
        let lineChartLineHeight: CGFloat = 2.0
        let lineChartLineWidth: CGFloat = min(bounds.width, bounds.height) * 2.0
        
        // Divide the chart into the number of columns
        let sidesOfColumnsBuffer = 20
        let maximumLineWidth = bounds.width - (CGFloat(sidesOfColumnsBuffer) * 2)
        let columnWidth = maximumLineWidth / CGFloat(numberOfColumns)
        
        // Create a path
        let lineChartPath = UIBezierPath()
        
        lineChartPath.lineWidth = lineChartLineHeight
        
        
        // Place the start of the path at the left of the line chart
        lineChartPath.moveToPoint(CGPoint(x: CGFloat(sidesOfColumnsBuffer), y: bounds.height / 2))
        
        lineChartPath.addLineToPoint(CGPoint(x: bounds.width - CGFloat(sidesOfColumnsBuffer), y: bounds.height / 3))
        
        // Setting line chart's color and drawing the line
        UIColor.blueColor().setStroke()
        lineChartPath.stroke()
        
// Hiding this example line drawing for now

//        //set up the width and height variables
//        //for the horizontal stroke
//        let plusHeight: CGFloat = 2.0
//        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 2.0
//        
//        //create the path
//        let plusPath = UIBezierPath()
//        
//        //set the path's line width to the height of the stroke
//        plusPath.lineWidth = plusHeight
//        
//        //move the initial point of the path
//        //to the start of the horizontal stroke
//        plusPath.moveToPoint(CGPoint(
//            x:bounds.width/2 - plusWidth/2,
//            y:bounds.height/2))
//        
//        //add a point to the path at the end of the stroke
//        plusPath.addLineToPoint(CGPoint(
//            x:bounds.width/2 + plusWidth/2,
//            y:bounds.height/2))
//        
//        //set the stroke color
//        UIColor.blueColor().setStroke()
//        
//        //draw the stroke
//        plusPath.stroke()
    }
}