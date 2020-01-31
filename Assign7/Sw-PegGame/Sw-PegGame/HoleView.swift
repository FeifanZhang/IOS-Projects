//
//  HoleView.swift
//  Sw-PegGame
//
//  Created by Steven Senger on 11/3/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class HoleView: UIControl {
    
    var active = false
    var index = 0
    
    override func draw(_ rect: CGRect) {
        if self.active {
            let lineLayer=CAShapeLayer()
            lineLayer.path=UIBezierPath(ovalIn: rect).cgPath
            lineLayer.fillColor=UIColor.lightGray.cgColor
            lineLayer.strokeColor=UIColor.yellow.cgColor
            let animation = CABasicAnimation(keyPath: "lineWidth")
            animation.fromValue = 1
            animation.toValue = 6
            animation.duration = 0.8
            animation.repeatCount=10000
            lineLayer.add(animation, forKey: "lineWidth")
            layer.addSublayer(lineLayer)
        }else{
            //直接使得sublayer为空即可
            layer.sublayers=[]
            UIColor.lightGray.set()
            UIBezierPath(ovalIn: rect).fill()
            self.layoutIfNeeded()
        }
        
    }
    
    
}
