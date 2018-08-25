//
//  RadioButton.swift
//  CustomRadioButton
//
//  Created by 陳鍵群 on 2018/5/1.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit
@IBDesignable

class RadioButton: UIButton {
    @IBInspectable var selectedButtonColor:UIColor = UIColor.black
    @IBInspectable var borderColor:UIColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        self.tintColor = UIColor.clear
        layer.cornerRadius = self.frame.width / 2
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 2.5
        layer.masksToBounds = true
    }
    override var isSelected: Bool{
        didSet{
            isClicked()
        }
    }
    func isClicked(){
        if isSelected{
            let insideLayer = CAShapeLayer()
            let path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.width / 2, y: bounds.height / 2))
            path.addArc(withCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: self.frame.width / 3, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
            insideLayer.path = path.cgPath
            insideLayer.fillColor = selectedButtonColor.cgColor
            insideLayer.name = "insideLayer"
            layer.addSublayer(insideLayer)
        }else{
            layer.sublayers?.filter({($0.name == "insideLayer")}).first?.removeFromSuperlayer()
        }
    }
}
