//
//  PieChart.swift
//  Analytics
//
//  Created by arizal on 16/11/18.
//  Copyright © 2018 Coders Colony. All rights reserved.
//

import UIKit
import Charts

class PieChart : UIView{
    @IBOutlet weak var pieChartView: PieChartView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let nib = UINib(nibName: "PieChart", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var pieChartEntry = [PieChartDataEntry]()
        let percentList = [20, 20, 35, 25]
        let labelList = ["Bugs", "Complete Task", "Incomplete Task", "Pending"]
        
        for (index, percent) in percentList.enumerated(){
            let value = PieChartDataEntry(value: Double(percent), label:labelList[index])
            pieChartEntry.append(value)
        }
        
        
        let pieChartDataSet = PieChartDataSet(values: pieChartEntry, label:nil)
        // Move-out the label in the inside slice to the outside slice
//        pieChartDataSet.xValuePosition = .outsideSlice
//        pieChartDataSet.yValuePosition = .outsideSlice
//        pieChartDataSet.valueLineWidth = 0.3
//        pieChartDataSet.valueLinePart1Length = 0.3
//        pieChartDataSet.valueLinePart2Length = 0.3
//        pieChartDataSet.valueLineVariableLength = false
        
        // Coloring the label in the slice
        pieChartDataSet.colors = getPieColor()
        
        let data = PieChartData()
        data.addDataSet(pieChartDataSet)
        
        // Coloring the value in the slice
        data.setValueTextColor(UIColor.white)
        
        //        let formatter = NumberFormatter()
        //        formatter.numberStyle = .none
        //        formatter.maximumFractionDigits = 1
        //        formatter.multiplier = 1.0
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter:pFormatter))
        
        pieChartView.data = data
        
        //hide chart description
        pieChartView.chartDescription?.enabled = false
        
        //set to to make doughnat
//        pieChartView.drawHoleEnabled = false

        //set hole radius
//        pieChartView.holeRadiusPercent = 0
        
    }
    
    func setCustomData(chartData : PieChartData){
        pieChartView.data = chartData
        pieChartView.setNeedsDisplay()
    }
    
    func setHalfPie(){
        pieChartView.holeColor = .white
        pieChartView.transparentCircleColor = NSUIColor.white.withAlphaComponent(0.43)
        pieChartView.holeRadiusPercent = 0.58
        pieChartView.rotationEnabled = false
        pieChartView.highlightPerTapEnabled = true
        pieChartView.drawHoleEnabled = true

        pieChartView.maxAngle = 180 // Half chart
        pieChartView.rotationAngle = 180 // Rotate to make the half on the upper side
        pieChartView.centerTextOffset = CGPoint(x: 0, y: -20)
    }
    
    func setAnimation(){
        pieChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    }
    
    func getPieColor() -> [NSUIColor]{
        return [NSUIColor(hexString: "#65962e"), NSUIColor(hexString: "#c36418"), NSUIColor(hexString: "#b8123e"), NSUIColor(hexString: "#3b5998")]
    }
}
