//
//  SideBarView.swift
//  Analytics
//
//  Created by arizal on 16/11/18.
//  Copyright © 2018 Coders Colony. All rights reserved.
//

import UIKit

class SideBarView : UIView{
    @IBOutlet weak var tableView: UITableView!
    
    var sideBarProtocol : SideBarProtocol?
    lazy var chartList = ["Pie Chart", "Line Chart", "Cubic Chart", "Bar Chart", "Combine Chart"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let nib = UINib(nibName: "SideBarView", bundle: nil)
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    open func setProtocol(sideBarProtocol : SideBarProtocol){
        self.sideBarProtocol = sideBarProtocol
    }
}

extension SideBarView : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = chartList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sideBarProtocol = self.sideBarProtocol{
            sideBarProtocol.onSelectMenu(menu: chartList[indexPath.row])
        }
    }
}

extension SideBarView : UITableViewDelegate{
    
}
