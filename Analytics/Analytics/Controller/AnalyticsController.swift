//
//  AnalyticsController.swift
//  Analytics
//
//  Created by arizal on 16/11/18.
//  Copyright © 2018 Coders Colony. All rights reserved.
//

import UIKit
import Charts

class AnalyticsController : UIViewController, SideBarProtocol{
    @IBOutlet weak var containerChart: UIView!
    @IBOutlet weak var customNavBar: UINavigationBar!
    
    lazy var pieChart: PieChart = PieChart()
    lazy var sidebar : SideBarView = SideBarView()
    lazy var lineChart : LineChart = LineChart()
    lazy var cubicChart : CubicLinesView = CubicLinesView()
    lazy var barChart : BarChart = BarChart()
    lazy var combineChart : CombineChartTable = CombineChartTable()
    lazy var customLegend : CustomLegend = CustomLegend()
    lazy var maskingView : UIView = UIView()
    lazy var isShowSideBar = false
    
    lazy var isShowCurrent = true
    lazy var isShowPrev = true
    lazy var isShowPrev2 = true
    lazy var isShowPrev3 = true
    
    var colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.orange]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        leftBarItem.imageInsets.left = 10
//        leftBarItem.imageInsets.left = 10
        
        setPieChart()
    }
    
    func setPieChart(){
        pieChart.frame = CGRect(x: 0, y: 0, width: containerChart.frame.width, height: containerChart.frame.height)
        containerChart.addSubview(pieChart)
        customNavBar.topItem?.title = "Pie Chart"
        pieChart.setAnimation()
    }
    
    func setLineChart(){
        lineChart.frame = CGRect(x: 0, y: 0, width: containerChart.frame.width, height: containerChart.frame.height)
        containerChart.addSubview(lineChart)
        customNavBar.topItem?.title = "Line Chart"
        lineChart.setXAnimation()
    }
    
    func setCubicChart(){
        cubicChart.frame = CGRect(x: 0, y: 0, width: containerChart.frame.width, height: containerChart.frame.height)
        containerChart.addSubview(cubicChart)
        customNavBar.topItem?.title = "Cubic Chart"
        cubicChart.setAnimation()
    }
    
    func setBarChart(){
        barChart.frame = CGRect(x: 0, y: 0, width: containerChart.frame.width, height: containerChart.frame.height-20)
        
        //must set data here
        let dummyData = self.getDummyData()
        let barChartData = self.getBarData(data: dummyData)
        let key = dummyData.value(forKey: "key") as! [String]
        
        barChart.setDummyBarChartData(chartData : barChartData, key:key)
        
        if !self.containerChart.isDescendant(of: self.barChart) {
            containerChart.addSubview(barChart)
            customNavBar.topItem?.title = "Bar Chart"
        }
        
        barChart.setAnimation()
    }
    
    func getDummyData() -> NSMutableDictionary{
        let dummyData = NSMutableDictionary()
        let key = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        let currentRevenue = [29,29,30,27,28,27,16,19,20,19,24,44]
        let currentRoomNight = [5,0,4,0,0,0,0,0,3,0,0,0]
        let currentBooking = [3,0,2,0,0,0,0,0,1,0,0,0]
        
        let prevRevenue = [27,12,19,14,74,35,51,47,27,19,12,50]
        let prevRoomNight = [25,11,17,12,66,31,45,41,24,0,11,0]
        let prevBooking = [10,3,9,6,26,12,23,20,15,0,2,0]
        
        let prev2Revenue = [48,86,29,24,43,84,40,24,79,17,11,85]
        let prev2RoomNight = [4,9,30,22,40,6,34,21,7,15,10,77]
        let prev2Booking = [2,4,7,8,13,4,13,8,5,4,5,28]
        
        let prev3Revenue = [15,15,13,14,13,11,11,17,54,1,29,39]
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
    
    func getBarData(data : NSMutableDictionary) -> BarChartData{
        let key = data.value(forKey: "key") as! [String]
        let current = data.value(forKey: "current") as! NSMutableDictionary
        let prev = data.value(forKey: "previous") as! NSMutableDictionary
        let prevTwo = data.value(forKey: "previous_two") as! NSMutableDictionary
        let prevThree = data.value(forKey: "previous_three") as! NSMutableDictionary
        
        let currentRevenue = current.value(forKey: "revenue") as! [Int]
        let prevRevenue = prev.value(forKey: "revenue") as! [Int]
        let prevTwoRevenue = prevTwo.value(forKey: "revenue") as! [Int]
        let prevThreeRevenue = prevThree.value(forKey: "revenue") as! [Int]
        
        var currentEntry = [BarChartDataEntry]()
        var prevEntry = [BarChartDataEntry]()
        var prevTwoEntry = [BarChartDataEntry]()
        var prevThreeEntry = [BarChartDataEntry]()
        
        for i in 0..<key.count{
            let current = BarChartDataEntry(x:Double(i), y:Double(currentRevenue[i]))
            let prev = BarChartDataEntry(x:Double(i), y:Double(prevRevenue[i]))
            let prevTwo = BarChartDataEntry(x:Double(i), y:Double(prevTwoRevenue[i]))
            let prevThree = BarChartDataEntry(x:Double(i), y:Double(prevThreeRevenue[i]))
            
            currentEntry.append(current)
            prevEntry.append(prev)
            prevTwoEntry.append(prevTwo)
            prevThreeEntry.append( prevThree)
        }
        
        let dataSet1 = BarChartDataSet(values: prevThreeEntry, label: "2015")
        dataSet1.setColor(NSUIColor.red)
        dataSet1.drawValuesEnabled = false
        
        let dataSet2 = BarChartDataSet(values: prevTwoEntry, label: "2016")
        dataSet2.setColor(NSUIColor.green)
        dataSet2.drawValuesEnabled = false
        
        let dataSet3 = BarChartDataSet(values: prevEntry, label: "2017")
        dataSet3.setColor(NSUIColor.blue)
        dataSet3.drawValuesEnabled = false
        
        let dataSet4 = BarChartDataSet(values: currentEntry, label: "2018")
        dataSet4.setColor(NSUIColor.orange)
        dataSet4.drawValuesEnabled = false
        
        var dataSets : [BarChartDataSet] = []
        if isShowCurrent{
            dataSets.append(dataSet4)
        }
        if isShowPrev{
            dataSets.append(dataSet3)
        }
        if isShowPrev2{
            dataSets.append(dataSet2)
        }
        if isShowPrev3{
            dataSets.append(dataSet1)
        }
        
        return dataSets.count == 1 ? BarChartData(dataSet: dataSets.first) : BarChartData(dataSets: dataSets)
    }
    
    func setCombineChart(){
        combineChart.frame = CGRect(x: 0, y: 0, width: containerChart.frame.width, height: containerChart.frame.height)
        containerChart.addSubview(combineChart)
        customNavBar.topItem?.title = "Combine Chart"
    }
    
    func setCustomLegend(){
        let number = 4
        let legendText = ["2015", "2016", "2017", "2018"]
        customLegend.frame = CGRect(x: 0, y: containerChart.frame.height - 20, width: 70*4, height: 20)
        customLegend.setNumberOfLegend(number: number)
        customLegend.setLegendsUI(colors: colors, text : legendText)
        for (index, view) in customLegend.stackView.subviews.enumerated(){
            if index == number{
                break
            }
            view.tag = index
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onClickLegend(_:)))
            view.addGestureRecognizer(gesture)
        }
        
        containerChart.addSubview(customLegend)
    }
    
    @objc func onClickLegend(_ sender: UITapGestureRecognizer){
        let view = sender.view
        let tag = view?.tag
        
        if tag == 0{
            isShowPrev3 = !isShowPrev3
            let color = colors[tag!] == UIColor.red ? UIColor.gray : UIColor.red
            colors[tag!] = color
        }
        else if tag == 1{
            isShowPrev2 = !isShowPrev2
            let color = colors[tag!] == UIColor.green ? UIColor.gray : UIColor.green
            colors[tag!] = color
        }
        else if tag == 2{
            isShowPrev = !isShowPrev
            let color = colors[tag!] == UIColor.blue ? UIColor.gray : UIColor.blue
            colors[tag!] = color
        }
        else{
            isShowCurrent = !isShowCurrent
            let color = colors[tag!] == UIColor.orange ? UIColor.gray : UIColor.orange
            colors[tag!] = color
        }
        
        for subView in (view?.subviews)!{
            if let label = subView as? UILabel{
                label.textColor = label.textColor == UIColor.black ? UIColor.gray : UIColor.black
            }
            else{
                subView.backgroundColor = colors[tag!]
            }
        }
        
        setBarChart()
        
    }
    
    @IBAction func onClickSideBar(_ sender: Any) {
        if !isShowSideBar{
            sidebar.frame = CGRect(x: 0, y: 0, width: containerChart.frame.width - 50, height: containerChart.frame.height)
            sidebar.setProtocol(sideBarProtocol: self)
            
            let gestureMasking = UITapGestureRecognizer(target: self, action: #selector(onClickMasking))
            maskingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            maskingView.frame = CGRect(x: 0, y: 0, width: containerChart.frame.width, height: containerChart.frame.height)
            maskingView.addGestureRecognizer(gestureMasking)
            
            containerChart.addSubview(maskingView)
            containerChart.addSubview(sidebar)
        }
        else{
            sidebar.removeFromSuperview()
            maskingView.removeFromSuperview()
        }
        isShowSideBar = !isShowSideBar
    }
    
    @objc func onClickMasking(){
        maskingView.removeFromSuperview()
        sidebar.removeFromSuperview()
    }
    
    func emptyContainer(){
        for view in containerChart.subviews{
            view.removeFromSuperview()
        }
    }
    
    //MARK: -SideBarProtocol
    func onSelectMenu(menu : String){
        switch menu {
        case "Pie Chart":
            emptyContainer()
            setPieChart()
            break
        case "Line Chart":
            emptyContainer()
            setLineChart()
            break
        case "Cubic Chart":
            emptyContainer()
            setCubicChart()
            break
        case "Bar Chart":
            emptyContainer()
            setBarChart()
            setCustomLegend()
            break
        default:
            emptyContainer()
            setCombineChart()
            break
        }
    }
    
}
