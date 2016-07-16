//
//  ChartView.swift
//  Get Moving
//
//  Created by Ryan on 12/30/15.
//  Copyright © 2015 Full Screen Ahead. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

class ChartView: UIView {

    var maximumChartHeight:CGFloat = CGFloat()
    var stepGoalRelativeToChartHeight: CGFloat = CGFloat()
    var goalLineShouldBeDrawn: Bool = Bool()
    var yValues:Array<Int> = []
    var stepGoal: Int!
    
    // This method draws the view, it will called when the view is displayed
    override func drawRect(rect: CGRect) {
        
        if (stepGoal == nil) {
            stepGoal = 6000
        }
        drawBarGraph(yValues, stepGoal: stepGoal)
        drawGoalLine()
    }
    
    func drawBarGraph(pedometerData: Array<Int>, stepGoal: Int){
        // Number of columns wanted in the line chart
        let numberOfColumns = pedometerData.count
        
        // Add spacing
        let spacingOnLineChartSides: CGFloat = 40
        let spacingBetweenBars: CGFloat = 1.0
        
        maximumChartHeight = CGFloat((2 * stepGoal) - (3 * (stepGoal / 10)))
        stepGoalRelativeToChartHeight = bounds.maxY - ((CGFloat(stepGoal) * bounds.maxY) / maximumChartHeight)
        
        // Divide the chart into an even number of columns
        let maximumChartWidth:CGFloat = bounds.width - (spacingOnLineChartSides * 2)
        //        let columnWidth:CGFloat = maximumChartWidth / (CGFloat(numberOfColumns) - 1)
        let barWidth:CGFloat = (maximumChartWidth - (spacingBetweenBars * CGFloat((numberOfColumns - 2)))) / CGFloat(numberOfColumns - 1)
        var arrayOfLines:[UIBezierPath] = []
        
        if (pedometerData.count > 0) {
            for _ in 0...(pedometerData.count - 1) {
                arrayOfLines.append(UIBezierPath())
            }
            
            
            for index in 0...(pedometerData.count - 1) {
                let yValue = CGFloat(pedometerData[Int(index)])
                let stepCountRelativeToChart = bounds.maxY - ((yValue * bounds.maxY) / maximumChartHeight)
                // Create a path and set the width
                arrayOfLines[Int(index)].lineWidth = barWidth
                
                // Place the start of the path at the left of the line chart with a slight buffer for aesthetics
                arrayOfLines[Int(index)].moveToPoint(CGPoint(x: spacingOnLineChartSides + (CGFloat(index) * spacingBetweenBars) + (CGFloat(index) * barWidth), y: bounds.maxY))
                
                arrayOfLines[Int(index)].addLineToPoint(CGPoint(x: spacingOnLineChartSides + (CGFloat(index) * spacingBetweenBars) + (CGFloat(index) * barWidth), y: stepCountRelativeToChart))
                
                // Setting line chart's color and drawing the line
                if stepCountRelativeToChart < stepGoalRelativeToChartHeight {
                    UIColor.orangeColor().setStroke()
                }
                else{
                    let button = UIButton()
                    button.tintColor.setStroke()
                }
                arrayOfLines[Int(index)].stroke()
            }
        }
    }
    
    func drawGoalLine() {
        
        let path = UIBezierPath()
        
        path.moveToPoint(CGPoint(x: bounds.minX, y: stepGoalRelativeToChartHeight))
        path.addLineToPoint(CGPoint(x: bounds.maxX, y: stepGoalRelativeToChartHeight))
        path.lineWidth = 2
        
        
        let dashes: [CGFloat] = [path.lineWidth * 0, path.lineWidth * 3]
        path.setLineDash(dashes, count: dashes.count, phase: 0)
        path.lineCapStyle = CGLineCap.Round
        
        UIColor.orangeColor().setStroke()
        path.stroke()
    }

}