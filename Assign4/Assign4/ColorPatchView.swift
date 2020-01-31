//
//  ColorPatchView.swift
//  Assign4
//
//  Created by 张非凡 on 10/12/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class ColorPatchView: UIView {
    
    var color = UIColor.white
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBAction func updateColor() {
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let red = CGFloat(self.redSlider.value)
        let green = CGFloat(self.greenSlider.value)
        let blue = CGFloat(self.blueSlider.value)
        self.color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        context?.setFillColor(self.color.cgColor)
        context?.fill(rect)
        context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
        context?.setLineWidth(3.0)
        context?.stroke(rect)
    }
}
