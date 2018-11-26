//
//  BarChart.swift
//  Analytics
//
//  Created by arizal on 16/11/18.
//  Copyright © 2018 Coders Colony. All rights reserved.
//

import UIKit
import Charts

class BarChart : UIView{
    @IBOutlet weak var barChartView: BarChartView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let nib = UINib(nibName: "BarChart", bundle: nil)
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
    }
    
    func setDummyBarChartData(chartData : BarChartData, key:[String]){
        // Y - Axis Setup
        let yaxis = barChartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        // X - Axis Setup
        let xAxis = barChartView.xAxis
        let formatter = CustomLabelsXAxisValueFormatter()//custom value formatter
        formatter.labels = key
        xAxis.valueFormatter = formatter
        
        xAxis.drawGridLinesEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.centerAxisLabelsEnabled = chartData.dataSetCount > 1
        xAxis.granularityEnabled = true
        xAxis.enabled = true
        
        barChartView.xAxis.axisMinimum = -0.5
        barChartView.xAxis.axisMaximum = Double(key.count - 1)
        
        if chartData.dataSetCount > 1{
            let groupSpace = 0.4
            let barSpace = 0.03
            let barWidth = 0.8/Double(chartData.dataSets.count)
            chartData.barWidth = barWidth
            barChartView.xAxis.axisMinimum = 0.0
            barChartView.xAxis.axisMaximum = 0.0 + chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(key.count)

            chartData.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)
        }
        
        barChartView.xAxis.granularity = chartData.dataSetCount == 1 ? 1 : barChartView.xAxis.axisMaximum / Double(key.count)
        
        barChartView.data = chartData
        barChartView.rightAxis.enabled = false
        barChartView.legend.enabled = false
        barChartView.leftAxis.enabled = false
        barChartView.chartDescription?.enabled = false
        barChartView.notifyDataSetChanged()
        barChartView.setVisibleXRangeMaximum(4)
    }
    
    func setAnimation(){
        self.barChartView.animate(yAxisDuration: 1.2, easingOption: .easeOutBounce)
    }
    
    func setCustomData(chartData : BarChartData){
        self.barChartView.data = chartData
    }
    
    func setChartXFormat(data : [String], groupWidth: Double){
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: data)
    }
}
