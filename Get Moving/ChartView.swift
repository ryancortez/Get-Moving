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
        let spacingOnLineChartSide: CGFloat = 40
        let spaceBetweenBars: CGFloat = 1.0
        
        maximumChartHeight = CGFloat((2 * stepGoal) - (3 * (stepGoal / 10)))
        stepGoalRelativeToChartHeight = bounds.maxY - ((CGFloat(stepGoal) * bounds.maxY) / maximumChartHeight)
        
        // Divide the chart into an even number of columns
        let maximumChartWidth:CGFloat = bounds.width - (spacingOnLineChartSide * 2)
        //        let columnWidth:CGFloat = maximumChartWidth / (CGFloat(numberOfColumns) - 1)
        let barWidth:CGFloat = (maximumChartWidth - (spaceBetweenBars * CGFloat((numberOfColumns - 2)))) / CGFloat(numberOfColumns - 1)
        var arrayOfBars:[UIBezierPath] = []
        
        if (pedometerData.count > 0) {
            for _ in 0...(pedometerData.count - 1) {
                arrayOfBars.append(UIBezierPath())
            }
            
            for index in 0...(pedometerData.count - 1) {
                let stepCountAbsolute = CGFloat(pedometerData[Int(index)])
                let stepCountRelativeToView = bounds.maxY - ((stepCountAbsolute * bounds.maxY) / maximumChartHeight)
                let barHorizontalPositionRelativeToView = spacingOnLineChartSide + (CGFloat(index) * spaceBetweenBars) + (CGFloat(index) * barWidth)
                // Create a path and set the width
                arrayOfBars[Int(index)].lineWidth = barWidth
                
                // Place the start of the path at the left of the line chart with a slight buffer for aesthetics
                arrayOfBars[Int(index)].moveToPoint(CGPoint(x: barHorizontalPositionRelativeToView, y: bounds.maxY))
                arrayOfBars[Int(index)].addLineToPoint(CGPoint(x: barHorizontalPositionRelativeToView, y: stepCountRelativeToView))
                
                // Setting line chart's color and drawing the line
                var labelColor = UIColor.blueColor()
                
                if stepCountRelativeToView < stepGoalRelativeToChartHeight {
                    UIColor.orangeColor().setStroke()
                    labelColor = UIColor.orangeColor()
                }
                else{
                    let button = UIButton()
                    button.tintColor.setStroke()
                }
                
                // Draw labels for each bar
                self.drawTextLabelsAboveBars(xValueForBar: barHorizontalPositionRelativeToView, yValueForBar: stepCountRelativeToView, barWidth: barWidth, absoluteValueForStepCount: stepCountAbsolute, withColor: labelColor)
                
                arrayOfBars[Int(index)].stroke()
            }
        }
    }
    
    func drawTextLabelsAboveBars(xValueForBar xValueForBar: CGFloat, yValueForBar: CGFloat, barWidth: CGFloat, absoluteValueForStepCount: CGFloat, withColor color: UIColor) {
        let labelHeight:CGFloat = 25
        let labelWidth:CGFloat = barWidth
        let label = UILabel(frame: CGRectMake(xValueForBar - (barWidth/2), yValueForBar - labelHeight, labelWidth, labelHeight))
        
        label.textAlignment = .Center
        label.textColor = color
        label.text = "\(Int(absoluteValueForStepCount))"
        self.addSubview(label)
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