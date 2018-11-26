//
//  CubicLinesView.swift
//  Analytics
//
//  Created by arizal on 16/11/18.
//  Copyright © 2018 Coders Colony. All rights reserved.
//

import UIKit
import Charts

private class CubicLineSampleFillFormatter: IFillFormatter {
    func getFillLinePosition(dataSet: ILineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
        return -10
    }
}

class CubicLinesView : UIView{
    @IBOutlet weak var lineChartView: LineChartView!
    var months = ["1 Jan 2017","2 Feb 2017","3 Mar 2017", "4 Apr 2017", "5 May 2017", "6 Jun 2017", "7 Jul 2017", "8 Aug 2017", "9 Sep 2017", "10 Oct 2017", "11 Nov 2017", "12 Dec 2017"]
    var amountOfClosed = [20,10,10,40,20,50,5,70,52,25,20,13]
    var amountOfNew = [37,15,4,14,2,5,5,7,20,2,2,11]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let nib = UINib(nibName: "CubicLinesView", bundle: nil)
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
        setCubicLinesChart()
    }
    
    func setAnimation(){
        self.lineChartView.animate(xAxisDuration: 2, yAxisDuration: 2)
    }
    
    func setCustomData(chartData : LineChartData){
        self.lineChartView.data = chartData
    }
    
    func setCubicLinesChart(){
        
        var lineChartEntryData1 = [ChartDataEntry]()
        var lineChartEntryData2 = [ChartDataEntry]()

        for i in 0..<self.months.count{
            let closeValue = ChartDataEntry(x:Double(i) ,y:Double(self.amountOfClosed[i]))
            lineChartEntryData1.append(closeValue)
            let newValue = ChartDataEntry(x:Double(i) ,y:Double(self.amountOfNew[i]))
            lineChartEntryData2.append(newValue)
        }

        let line1 = LineChartDataSet(values: lineChartEntryData1, label: "Open")
        line1.colors = [NSUIColor.red]
        line1.drawCubicEnabled = true
        line1.drawCirclesEnabled = true
        line1.circleColors = [NSUIColor.red]
        line1.drawFilledEnabled = true
        line1.fillColor = NSUIColor.red

        let line2 = LineChartDataSet(values: lineChartEntryData2, label: "Closed")
        line2.colors = [NSUIColor.green]
        line2.drawCubicEnabled = true
        line2.drawCirclesEnabled = true
        line2.circleColors = [NSUIColor.green]
        line2.drawFilledEnabled = true
        line2.fillColor = NSUIColor.green

        var dataSets : [LineChartDataSet] = []
        dataSets.append(line1)
        dataSets.append(line2)
        
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
        self.lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: self.months)

        self.lineChartView.backgroundColor = UIColor.white
        self.lineChartView.chartDescription?.enabled = false
        
        self.lineChartView.rightAxis.enabled = true
        
        self.lineChartView.legend.enabled = true
        self.lineChartView.legend.verticalAlignment = .bottom
        self.lineChartView.legend.horizontalAlignment = .left
        self.lineChartView.legend.orientation = .horizontal
        
        self.lineChartView.rightAxis.enabled = false
        
        self.lineChartView.leftAxis.enabled = true
        self.lineChartView.leftAxis.drawAxisLineEnabled = false
        self.lineChartView.leftAxis.drawLimitLinesBehindDataEnabled = true
        
        self.lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.lineChartView.xAxis.drawAxisLineEnabled = false
        self.lineChartView.xAxis.drawGridLinesEnabled = false
        self.lineChartView.xAxis.wordWrapEnabled = true
        self.lineChartView.xAxis.labelWidth = 10
        self.lineChartView.xAxis.granularityEnabled = true
        self.lineChartView.xAxis.granularity = 1
    }
}
