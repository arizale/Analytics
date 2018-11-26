//
//  LineChart.swift
//  Analytics
//
//  Created by arizal on 16/11/18.
//  Copyright © 2018 Coders Colony. All rights reserved.
//

import UIKit
import Charts

class LineChart : UIView{
    @IBOutlet weak var lineChartView: LineChartView!
    
    var date = ["1 Jan 2017","2 Feb 2017","3 Mar 2017", "4 Apr 2017", "5 May 2017", "6 Jun 2017", "7 Jul 2017", "8 Aug 2017", "9 Sep 2017", "10 Oct 2017", "11 Nov 2017", "12 Dec 2017"]
    var amountOfClosed = [20,10,10,40,20,50,5,70,52,25,20,13]
    var amountOfNew = [37,15,4,14,2,5,5,7,20,2,2,11]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let nib = UINib(nibName: "LineChart", bundle: nil)
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
        setLineChart()
    }
    
    func setLineChart(){
        var line1 = [ChartDataEntry]()
        var line2 = [ChartDataEntry]()
        
        for i in 0..<date.count{
            let closedValue = ChartDataEntry(x:Double(i) ,y:Double(self.amountOfClosed[i]))
            line1.append(closedValue)
            
            let openValue = ChartDataEntry(x:Double(i) ,y:Double(self.amountOfNew[i]))
            line2.append(openValue)
        }

        
        let dataSet1 = LineChartDataSet(values: line1, label: "Open")
        dataSet1.drawIconsEnabled = false
        dataSet1.lineDashLengths = [5, 2.5]
        dataSet1.highlightLineDashLengths = [5, 2.5]
        dataSet1.setColor(.red)
        dataSet1.setCircleColor(.red)
        dataSet1.lineWidth = 1
        dataSet1.circleRadius = 3
        dataSet1.drawCircleHoleEnabled = false
        dataSet1.valueFont = .systemFont(ofSize: 9)
        dataSet1.formLineDashLengths = [5, 2.5]
        dataSet1.formLineWidth = 1
        dataSet1.formSize = 12
        
        let dataSet2 = LineChartDataSet(values: line2, label: "Closed")
        dataSet2.drawIconsEnabled = false
        dataSet2.lineDashLengths = [5, 2.5]
        dataSet2.highlightLineDashLengths = [5, 2.5]
        dataSet2.setColor(.green)
        dataSet2.setCircleColor(.green)
        dataSet2.lineWidth = 1
        dataSet2.circleRadius = 3
        dataSet2.drawCircleHoleEnabled = false
        dataSet2.valueFont = .systemFont(ofSize: 9)
        dataSet2.formLineDashLengths = [5, 2.5]
        dataSet2.formLineWidth = 1
        dataSet2.formSize = 12
        
        var dataSets : [LineChartDataSet] = []
        dataSets.append(dataSet1)
        dataSets.append(dataSet2)
        
        //for gradient color
//        let gradientColors = [ChartColorTemplates.colorFromString("#000000").cgColor,
//                              ChartColorTemplates.colorFromString("#ffffff").cgColor]
//        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
//
//        set1.fillAlpha = 1
//        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
//        set1.drawFilledEnabled = false
        
        //legend
        let legend = lineChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0
        legend.xOffset = 10.0
        legend.yEntrySpace = 5.0
        
        let chartData = LineChartData(dataSets: dataSets)
        self.lineChartView.data = chartData
        self.lineChartView.backgroundColor = UIColor.white
        self.lineChartView.chartDescription?.enabled = false
        
        self.lineChartView.leftAxis.enabled = false
        self.lineChartView.rightAxis.enabled = false
        
        self.lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.lineChartView.xAxis.drawAxisLineEnabled = true
        self.lineChartView.xAxis.drawGridLinesEnabled = false
        self.lineChartView.xAxis.wordWrapEnabled = true
        self.lineChartView.xAxis.labelWidth = 10
        self.lineChartView.xAxis.granularityEnabled = true
        self.lineChartView.xAxis.granularity = 1
        self.lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: self.date)
    }
    
    func setCustomData(chartData : LineChartData){
        self.lineChartView.data = chartData
    }
    
    func setYAnimation(){
        self.lineChartView.animate(yAxisDuration: 1.5, easingOption: .easeOutBounce)
    }
    
    func setXAnimation(){
        self.lineChartView.animate(xAxisDuration: 1.5)
    }
    
    func setCustomLegends(){
        //legend
        let legend = lineChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .left
        legend.verticalAlignment = .top
        legend.orientation = .horizontal
        legend.drawInside = true
        legend.yOffset = 10.0
        legend.xOffset = 10.0
        legend.yEntrySpace = 5.0
    }
}
