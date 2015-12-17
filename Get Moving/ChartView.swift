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
        drawLineForChart()
    
        

    }
    
    func drawLineForChart() {
        let arrayOfData = [45, 11002, 3632, 616, 11002, 14002, 5]
        
        // Number of columns wanted in the line chart
        let numberOfColumns = arrayOfData.count
        let maximumChartYValue: CGFloat = 17000
        let lineChartLineHeight: CGFloat = 7.0
        
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
        for index in 1...6 {
            lineChartPath.addLineToPoint(CGPoint(x: spacingOnLineChartSides + (CGFloat(index) * columnWidth), y: bounds.height - (bounds.height * CGFloat(arrayOfData[index]) / CGFloat(maximumChartYValue) + spacingUndertheLineChart)))
            print("Current Point for index (\(index)): (\(lineChartPath.currentPoint.x), \(lineChartPath.currentPoint.y))")
        }
        
        // Setting line chart's color and drawing the line
        UIColor.blueColor().setStroke()
        lineChartPath.stroke()
    }
    func drawGoalLine() {
        let goalLine = UIBezierPath()
        
    }
    
    
}