//
//  DailyChartView.swift
//  Get Moving
//
//  Created by Ryan on 12/11/15.
//  Copyright © 2015 Full Screen Ahead. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class DailyChartView: UIView {
    
    var maximumChartHeight:CGFloat = CGFloat()
    var stepGoalRelativeToChartHeight: CGFloat = CGFloat()
    var goalLineShouldBeDrawn: Bool = Bool()
    
    func pullPedometerData() -> Array<CGFloat>{
        // This is a temporary set of test data. This will be changed when Pedometer Data's implemenation is done
        let arrayOfData:[CGFloat] = [40000, 6299, 5925, 3962, 7089, 11002, 11002]
    
        return arrayOfData
    }
    
    func pullStepGoal() -> Int{
        // This is a temporary magic number to test the drawing of the goal line, this will be relplaced when Settings is implemented
        return 12000
    }
    
    // This method draws the view, it will called when the view is displayed
    override func drawRect(rect: CGRect) {
        
        let goal = pullStepGoal()
        
        drawBarGraph(pullPedometerData(), stepGoal: goal)
        drawGoalLine()
    }
    
    func drawBarGraph(pedometerData: Array<CGFloat>, stepGoal: Int){

        // Number of columns wanted in the line chart
        let numberOfColumns = pedometerData.count
        
        // Add spacing
        let spacingOnLineChartSides: CGFloat = 40
        let spacingBetweenBars: CGFloat = 1.0
        
        maximumChartHeight = CGFloat((2 * stepGoal) - (3 * (stepGoal / 10)))
        stepGoalRelativeToChartHeight = bounds.maxY - ((CGFloat(stepGoal) * bounds.maxY) / maximumChartHeight)

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
        
        for _ in 0...(pedometerData.count - 1) {
            arrayOfLines.append(UIBezierPath())
        }
        
        for index in 0...(pedometerData.count - 1) {
            let stepCountRelativeToChart = bounds.maxY - ((pedometerData[Int(index)] * bounds.maxY) / maximumChartHeight)
            
            print("arrayOfData.count: \(pedometerData.count)")
            print("Index value: \(Int(index))")
            
            // Create a path and set the width
            arrayOfLines[Int(index)].lineWidth = barWidth
            
            // Place the start of the path at the left of the line chart with a slight buffer for aesthetics
            arrayOfLines[Int(index)].moveToPoint(CGPoint(x: spacingOnLineChartSides + (CGFloat(index) * spacingBetweenBars) + (CGFloat(index) * barWidth), y: bounds.maxY))
            
            print("Initial Point: (\(arrayOfLines[Int(index)].currentPoint.x), \(arrayOfLines[Int(index)].currentPoint.y))")
            
            arrayOfLines[Int(index)].addLineToPoint(CGPoint(x: spacingOnLineChartSides + (CGFloat(index) * spacingBetweenBars) + (CGFloat(index) * barWidth), y: stepCountRelativeToChart))
            
            print("arrayOfData[\(Int(index))]: \(pedometerData[Int(index)])")
            print("Current Point: (\(arrayOfLines[Int(index)].currentPoint.x), \(arrayOfLines[Int(index)].currentPoint.y))")
            
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