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
//        setBarChart()
//        setDummyBar()
    }
    
    func getDummyData() -> NSMutableDictionary{
        let dummyData = NSMutableDictionary()
        let key = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        let currentRevenue = [5849992,0,5320010,0,0,0,0,0,3361086,0,0,0]
        let currentRoomNight = [5,0,4,0,0,0,0,0,3,0,0,0]
        let currentBooking = [3,0,2,0,0,0,0,0,1,0,0,0]
        
        let prevRevenue = [27952450,12318019,19158225,14022423,74836369,35185000,51752477,47500483,27031164,0,12430000,0]
        let prevRoomNight = [25,11,17,12,66,31,45,41,24,0,11,0]
        let prevBooking = [10,3,9,6,26,12,23,20,15,0,2,0]
        
        let prev2Revenue = [4870000,8685000,29430000,24560000,43875000,8480000,40954051,24730000,7910000,17473038,11131088,85925748]
        let prev2RoomNight = [4,9,30,22,40,6,34,21,7,15,10,77]
        let prev2Booking = [2,4,7,8,13,4,13,8,5,4,5,28]
        
        let prev3Revenue = [0,0,0,0,0,0,1190000,1780000,5400000,0,29340000,3920000]
        let prev3RoomNight = [0,0,0,0,0,0,1,2,5,0,27,4]
        let prev3Booking = [0,0,0,0,0,0,1,2,4,0,4,2]
        
        let lastYear = NSMutableDictionary()
        
        let vsPrevious = NSMutableDictionary()
        vsPrevious.setValue(-72.2, forKey: "revenue")
        vsPrevious.setValue(-77.8, forKey: "booking")
        vsPrevious.setValue(-76.5, forKey: "roomnight")
        
        let vsLastYear = NSMutableDictionary()
        vsLastYear.setValue(100, forKey: "revenue")
        vsLastYear.setValue(100, forKey: "booking")
        vsLastYear.setValue(100, forKey: "roomnight")
        
        let currentObj = NSMutableDictionary()
        currentObj.setValue(currentRevenue, forKey: "revenue")
        currentObj.setValue(currentRoomNight, forKey: "roomNight")
        currentObj.setValue(currentBooking, forKey: "booking")
        
        let prevObj = NSMutableDictionary()
        prevObj.setValue(prevRevenue, forKey: "revenue")
        prevObj.setValue(prevRoomNight, forKey: "roomNight")
        prevObj.setValue(prevBooking, forKey: "booking")
        
        let prev2Obj = NSMutableDictionary()
        prev2Obj.setValue(prev2Revenue, forKey: "revenue")
        prev2Obj.setValue(prev2RoomNight, forKey: "roomNight")
        prev2Obj.setValue(prev2Booking, forKey: "booking")
        
        let prev3Obj = NSMutableDictionary()
        prev3Obj.setValue(prev3Revenue, forKey: "revenue")
        prev3Obj.setValue(prev3RoomNight, forKey: "roomNight")
        prev3Obj.setValue(prev3Booking, forKey: "booking")
        
        dummyData.setValue(key, forKey: "key")
        dummyData.setValue(currentObj, forKey: "current")
        dummyData.setValue(prevObj, forKey: "previous")
        dummyData.setValue(prev2Obj, forKey: "previous_two")
        dummyData.setValue(prev3Obj, forKey: "previous_three")
        dummyData.setValue(lastYear, forKey: "last_year")
        dummyData.setValue(vsPrevious, forKey: "vs_previous")
        dummyData.setValue(vsLastYear, forKey: "vs_last_year")
        
        return dummyData
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
