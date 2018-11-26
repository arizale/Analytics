//
//  CustomLegend.swift
//  Analytics
//
//  Created by arizal on 21/11/18.
//  Copyright © 2018 Coders Colony. All rights reserved.
//

import UIKit

class CustomLegend : UIView{
    @IBOutlet weak var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let nib = UINib(nibName: "CustomLegend", bundle: nil)
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
    
    func setLegendsUI(colors : [UIColor],  text: [String]){
        let count = colors.count
        for (index, view) in stackView.subviews.enumerated(){
            if index == count{
                break
            }
            
            for subView in view.subviews{
                if let label = subView as? UILabel{
                    label.text = text[index]
                }
                else{
                    subView.backgroundColor = colors[index]
                }
            }
        }
    }
    
    func setNumberOfLegend(number : Int){
        for (index, view) in stackView.subviews.enumerated(){
            if index == number{
                break
            }
            view.isHidden = false
        }
    }
}
