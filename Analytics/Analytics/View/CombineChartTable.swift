//
//  CombineChartTable.swift
//  Analytics
//
//  Created by arizal on 18/11/18.
//  Copyright © 2018 Coders Colony. All rights reserved.
//

import UIKit
import Charts

class CombineChartTable : UIView{
    @IBOutlet weak var tableView: UITableView!
    
    let groupSpace = 0.08
    let barSpace = 0.03
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let nib = UINib(nibName: "CombineChartTable", bundle: nil)
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
        tableView.register(UINib(nibName: "CombineChartCell", bundle: nil), forCellReuseIdentifier: "CombineChartCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getTaskData() -> LineChartData{
        var incompletedArr = [1,3,2,3,3,1,0,5,7,9,6,4]
        var completedArr = [21,23,22,23,23,21,20,25,27,29,26,24]
        
        var line1 = [ChartDataEntry]()
        var line2 = [ChartDataEntry]()
        
        for i in 0..<incompletedArr.count{
            let incompleted = ChartDataEntry(x:Double(i) ,y:Double(incompletedArr[i]))
            line1.append(incompleted)
            
            let completed = ChartDataEntry(x:Double(i) ,y:Double(completedArr[i]))
            line2.append(completed)
        }
        
        let dataSet1 = LineChartDataSet(values: line1, label: "Incompleted")
        dataSet1.drawIconsEnabled = false
        dataSet1.setColor(.red)
        dataSet1.setCircleColor(.red)
        dataSet1.lineWidth = 1
        dataSet1.circleRadius = 2
        dataSet1.drawCircleHoleEnabled = false
        dataSet1.valueFont = .systemFont(ofSize: 9)
        dataSet1.formLineDashLengths = [5, 2.5]
        dataSet1.formLineWidth = 1
        dataSet1.formSize = 12
//        dataSet1.drawCubicEnabled = true
        
        let dataSet2 = LineChartDataSet(values: line2, label: "Completed")
        dataSet2.drawIconsEnabled = false
        dataSet2.setColor(.green)
        dataSet2.setCircleColor(.green)
        dataSet2.lineWidth = 4
        dataSet2.circleRadius = 5
        dataSet2.drawCircleHoleEnabled = false
        dataSet2.valueFont = .systemFont(ofSize: 9)
        dataSet2.formLineDashLengths = [5, 2.5]
        dataSet2.formLineWidth = 4
        dataSet2.formSize = 12
//        dataSet2.drawCubicEnabled = true
        
        let chartData = LineChartData(dataSets: [dataSet1, dataSet2])
        
        return chartData
    }
    
    func getBugsInformation() -> PieChartData{
        let percentList = [70, 30]
        let labelList = ["New", "Closed"]
        
        var pieChartEntry = [PieChartDataEntry]()
        for (index, percent) in percentList.enumerated(){
            let value = PieChartDataEntry(value: Double(percent), label:labelList[index])
            pieChartEntry.append(value)
        }
        
        let pieChartDataSet = PieChartDataSet(values: pieChartEntry, label:nil)
        pieChartDataSet.colors = [NSUIColor.red, NSUIColor.blue]
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        
        let data = PieChartData()
        data.addDataSet(pieChartDataSet)
        data.setValueTextColor(UIColor.white)
        data.setValueFormatter(DefaultValueFormatter(formatter:pFormatter))
        
        return data
    }
    
    func getTotalBugsData() -> LineChartData{
        var totalBugsArr = [1,3,2,3,3,1,0,5,7,9,6,4]
        
        var line1 = [ChartDataEntry]()
        
        for i in 0..<totalBugsArr.count{
            let totalBugs = ChartDataEntry(x:Double(i) ,y:Double(totalBugsArr[i]))
            line1.append(totalBugs)
        }
        
        let dataSet1 = LineChartDataSet(values: line1, label: "Bugs")
        dataSet1.drawIconsEnabled = false
        dataSet1.setColor(.blue)
        dataSet1.setCircleColor(.blue)
        dataSet1.lineWidth = 2
        dataSet1.circleRadius = 3
        dataSet1.drawCircleHoleEnabled = false
        dataSet1.valueFont = .systemFont(ofSize: 9)
        dataSet1.formLineDashLengths = [5, 2.5]
        dataSet1.formLineWidth = 2
        dataSet1.formSize = 12
        dataSet1.drawFilledEnabled = true
        dataSet1.fillAlpha = 0.2
        dataSet1.fill = Fill(color: .blue)
        
        dataSet1.drawCubicEnabled = true
        let chartData = LineChartData(dataSets: [dataSet1])
        
        return chartData
    }
}

extension CombineChartTable : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let combineChartCell = tableView.dequeueReusableCell(withIdentifier: "CombineChartCell", for: indexPath) as! CombineChartCell
        
        for view in combineChartCell.containerView.subviews{
            view.removeFromSuperview()
        }
        
        switch indexPath.row {
        case 0:
            let lineChart = LineChart(frame: CGRect(x: 0, y: 0, width: combineChartCell.containerView.frame.width, height: combineChartCell.containerView.frame.height))
            lineChart.setCustomData(chartData: self.getTaskData())
            lineChart.setCustomLegends()
            lineChart.setXAnimation()
            
            combineChartCell.titleLabel.text = "Task Overview"
            combineChartCell.containerView.addSubview(lineChart)
        case 1:
            let pieChart = PieChart(frame: CGRect(x: 0, y: 0, width: combineChartCell.containerView.frame.width, height: combineChartCell.containerView.frame.height))
            pieChart.setCustomData(chartData: self.getBugsInformation())
            pieChart.setHalfPie()
            pieChart.setAnimation()
            
            combineChartCell.titleLabel.text = "New Bugs vs Closed Bugs"
            combineChartCell.containerView.addSubview(pieChart)
            break
        case 2:
            let lineChart = LineChart(frame: CGRect(x: 0, y: 0, width: combineChartCell.containerView.frame.width, height: combineChartCell.containerView.frame.height))
            lineChart.setCustomData(chartData: self.getTotalBugsData())
            lineChart.setCustomLegends()
            lineChart.lineChartView.legend.enabled = false
            lineChart.setYAnimation()
            
            combineChartCell.titleLabel.text = "Bugs Overview"
            combineChartCell.containerView.addSubview(lineChart)
            break
        default:
            let horizontalBarChart = HorizontalBarChart(frame: CGRect(x: 0, y: 0, width: combineChartCell.containerView.frame.width, height: combineChartCell.containerView.frame.height))
            
            combineChartCell.titleLabel.text = "Horizontal"
            combineChartCell.containerView.addSubview(horizontalBarChart)
            break
        }
        
        
        combineChartCell.selectionStyle = UITableViewCellSelectionStyle.none
        return combineChartCell
    }
}

extension CombineChartTable : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
}
