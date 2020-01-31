//
//  SwishGestureView.swift
//  Sw-SwishGesture
//
//  Created by Steven Senger on 11/19/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class SwishGestureView: UIView {
  
  var gesture: SwishGestureRecognizer!
  
  override func draw(_ rect: CGRect) {
    guard self.gesture != nil else { return }
    let path = UIBezierPath()
    UIColor.blue.set()
    path.lineWidth = 6
    path.move(to: self.gesture.endPt)
    path.addLine(to: self.gesture.turnPt)
    path.stroke()
    path.removeAllPoints()
    UIColor.red.set()
    path.lineWidth = 2
    path.move(to: self.gesture.turnPt)
    path.addLine(to: self.gesture.startPt)
    path.stroke()
    self.setNeedsDisplay()
  }
}
