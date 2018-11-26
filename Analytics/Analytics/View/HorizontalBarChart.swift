//
//  HorizontalBarChart.swift
//  Analytics
//
//  Created by arizal on 19/11/18.
//  Copyright © 2018 Coders Colony. All rights reserved.
//

import UIKit
import Charts

class HorizontalBarChart : UIView{
    @IBOutlet weak var horizontalChartView: HorizontalBarChartView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let nib = UINib(nibName: "HorizontalBarChart", bundle: nil)
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
        setHorizontalBar()
    }
    
    func setHorizontalBar(){
        let bugsList = [20, 20, 35, 25]
        let titleList = ["Bugs", "Completed Task", "Incomplete Task", "Pending"]
        
        var bugsDataEntry = [BarChartDataEntry]()
        
        for i in 0..<bugsList.count{
            let bugs = BarChartDataEntry(x:Double(i)+0.5, y:Double(bugsList[i]))
            bugsDataEntry.append(bugs)
        }
        
        let dataSet1 = BarChartDataSet(values: bugsDataEntry, label: "Bugs")
        dataSet1.drawIconsEnabled = false
        dataSet1.drawValuesEnabled = false
        dataSet1.colors = ChartColorTemplates.colorful()
        
        let barChartData = BarChartData(dataSet: dataSet1)
        
        let xAxis = horizontalChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = IndexAxisValueFormatter(values: titleList)
        xAxis.granularity = 1
        xAxis.centerAxisLabelsEnabled = true
        
        let leftAxis = horizontalChartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.enabled = false
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawGridLinesEnabled = false
        leftAxis.axisMinimum = 0.5
        
        let rightAxis = horizontalChartView.rightAxis
        rightAxis.enabled = false
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawGridLinesEnabled = false
        rightAxis.axisMinimum = 0.5

        horizontalChartView.fitBars = true
        horizontalChartView.drawValueAboveBarEnabled = true
        horizontalChartView.maxVisibleCount = 60
        horizontalChartView.data = barChartData
        horizontalChartView.legend.enabled = false
        horizontalChartView.animate(yAxisDuration: 2.5)
    }
}
