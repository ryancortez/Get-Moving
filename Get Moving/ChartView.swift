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
    
    var stepGoal = 10000
    
    override func drawRect(rect: CGRect) {
        drawBarGraph()
        
        
    }
    
    func drawBarGraph(){
        let arrayOfData:[CGFloat] = [11002, 11002, 3632, 616, 11002, 14002, 11002 ]
        
        // Number of columns wanted in the line chart
        let numberOfColumns = arrayOfData.count
        
        
        // Add spacing
        let spacingOnLineChartSides: CGFloat = 40
        //        let spacingUndertheLineChart: CGFloat = 5
        let spacingBetweenBars: CGFloat = 1.0
        
        // Divide the chart into an even number of columns
        let maximumChartWidth:CGFloat = bounds.width - (spacingOnLineChartSides * 2)
        let columnWidth:CGFloat = maximumChartWidth / (CGFloat(numberOfColumns) - 1)
        let barWidth:CGFloat = (maximumChartWidth - (spacingBetweenBars * CGFloat((numberOfColumns - 2)))) / CGFloat(numberOfColumns - 1)
        print("bounds.width: \(bounds.width)")
        print("bounds.height: \(bounds.height)")
        print("maximumLineWidth: \(maximumChartWidth)")
        print("columnWidth: \(columnWidth)")
        print("numberOfColumns: \(numberOfColumns)")
        
        var arrayOfLines:[UIBezierPath] = []
        
        for _ in 0...(arrayOfData.count - 1) {
            
            arrayOfLines.append(UIBezierPath())
            
        }
        
        for index in 0...(arrayOfData.count - 1) {
            
            print("arrayOfData.count: \(arrayOfData.count)")
            
            print("Index value: \(Int(index))")
            // Create a path and set the width
            arrayOfLines[Int(index)].lineWidth = barWidth
            
            // Place the start of the path at the left of the line chart with a slight buffer for aesthetics
            arrayOfLines[Int(index)].moveToPoint(CGPoint(x: spacingOnLineChartSides + (CGFloat(index) * spacingBetweenBars) + (CGFloat(index) * barWidth), y: bounds.maxY))
            print("Initial Point: (\(arrayOfLines[Int(index)].currentPoint.x), \(arrayOfLines[Int(index)].currentPoint.y))")
            
            arrayOfLines[Int(index)].addLineToPoint(CGPoint(x: spacingOnLineChartSides + (CGFloat(index) * spacingBetweenBars) + (CGFloat(index) * barWidth), y: bounds.maxY - ((arrayOfData[Int(index)] * bounds.maxY) / maximumChartHeight)))
            print("arrayOfData[\(Int(index))]: \(arrayOfData[Int(index)])")
            print("Current Point: (\(arrayOfLines[Int(index)].currentPoint.x), \(arrayOfLines[Int(index)].currentPoint.y))")
            
            // Setting line chart's color and drawing the line
            let button = UIButton()
            button.tintColor.setStroke()
            arrayOfLines[Int(index)].stroke()
        }
    }
    /*
    func drawLineForChart() {
    
    let arrayOfData = [45, 11002, 3632, 616, 11002, 14002, 5]
    
    // Number of columns wanted in the line chart
    let numberOfColumns = arrayOfData.count
    let maximumChartYValue: CGFloat = 17000
    let lineChartLineHeight: CGFloat = 7.0
    let numberOfDataPoints = arrayOfData.count
    
    // Add spacing
    let spacingOnLineChartSides: CGFloat = 20
    let spacingUndertheLineChart: CGFloat = 5
    
    // Divide the chart into an even number of columns
    let maximumLineWidth:CGFloat = bounds.width - (spacingOnLineChartSides * 2)
    let columnWidth:CGFloat = maximumLineWidth / (CGFloat(numberOfColumns) - 1)
    print(bounds.width)
    print("maximumLineWidth: \(maximumLineWidth)")
    print("columnWidth: \(columnWidth)")
    print("numberOfColumns: \(numberOfColumns)")
    
    // Create a path and set the width
    let lineChartPath = UIBezierPath()
    lineChartPath.lineWidth = lineChartLineHeight
    
    // Place the start of the path at the left of the line chart with a slight buffer for aesthetics
    lineChartPath.moveToPoint(CGPoint(x: CGFloat(spacingOnLineChartSides), y: bounds.height - (bounds.height * CGFloat(arrayOfData[0]) / CGFloat(maximumChartYValue) + spacingUndertheLineChart)))
    print("Initial Point: (\(lineChartPath.currentPoint.x), \(lineChartPath.currentPoint.y))")
    
    // Draw the rest of the line using the data provided, there is a buffer for the inital point/column width
    for index in 1...(numberOfDataPoints - 1) {
    lineChartPath.addLineToPoint(CGPoint(x: spacingOnLineChartSides + (CGFloat(index) * columnWidth), y: bounds.height - (bounds.height * CGFloat(arrayOfData[index]) / CGFloat(maximumChartYValue) + spacingUndertheLineChart)))
    print("Current Point for index (\(index)): (\(lineChartPath.currentPoint.x), \(lineChartPath.currentPoint.y))")
    }
    
    // Setting line chart's color and drawing the line
    UIColor.blueColor().setStroke()
    lineChartPath.stroke()
    }
    */
    func drawGoalLine() {
        let dotWidth:CGFloat = 3
        let numberOfDots = Int(bounds.maxX) / Int(dotWidth)
        
        for index in 0...numberOfDots {
            let rect = CGRectMake(CGFloat(index) * dotWidth, ((bounds.maxY * CGFloat(stepGoal)) / CGFloat(stepGoal) + 7000) , dotWidth, dotWidth)
            let goalDot = UIBezierPath(ovalInRect: rect)
            UIColor.grayColor().setFill()
            goalDot.fill()
        }
        
        
    }
    
    
}