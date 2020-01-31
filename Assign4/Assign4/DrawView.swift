//
//  DrawView.swift
//  Assign4
//
//  Created by Steven Senger on 9/29/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
  var color = UIColor.white
  var curveList = [UIBezierPath]()
  var currentPath: UIBezierPath?
  var curveListColor = [UIColor]()
  var dashed = false
  
  var lineWidth: Float = 1.0
  var hasMoved = false
  var deleteCurveList = [UIBezierPath]()
  var delteCurveColour = [UIColor]()
  var frontStep = 1
  var storeColor = UIColor.white
    var storeLineWidth:Float = 1.0
    
  @IBAction func eraser(sender:UISwitch){
    if(sender.isOn==true){//is eraser
        self.storeColor=self.color
        color=UIColor.white
        self.storeLineWidth=self.lineWidth
        lineWidth=5.0
    }else{//is not eraser
        self.color=self.storeColor
        self.lineWidth=self.storeLineWidth
        storeColor=UIColor.white
        storeLineWidth=1.0
    }
  }
    
  @IBAction func updateCurveList(sender:UIStepper){
    
    print("sender value is:\(sender.value)")
    print("curveList value is:\(curveList.count)")
    print("frontStep is\(self.frontStep)")
    if(self.frontStep-Int(sender.value)<0){//stepper for"+"button
        print("stepper for + button")
        if(self.curveList.count==0){//curveList is nil
            print("curveList is nil")
            if(self.deleteCurveList.count != 0){//deleteCuriveList is not nil
                print("deleteCuriveList is not nil")
                self.curveList.append(self.deleteCurveList.remove(at: self.deleteCurveList.count-1))
                self.curveListColor.append(self.delteCurveColour.remove(at: self.delteCurveColour.count-1))
                self.frontStep=curveList.count
                sender.value=Double(curveList.count)
            }else{//deleteCurve is nil CurveList数字下标越界
                print("deleteCurve is nil")
                self.frontStep=1
                sender.value=1
            }
            
        }else{//curveList is not nil
            print("curveList is not nil")
            if(self.deleteCurveList.count != 0){//deleteCuriveList is not nil
                print("deleteCuriveList is not nil")
                self.curveList.append(self.deleteCurveList.remove(at: self.deleteCurveList.count-1))
                self.curveListColor.append(self.delteCurveColour.remove(at: self.delteCurveColour.count-1))
                self.frontStep=curveList.count
                sender.value=Double(curveList.count)
            }else{//deleteCurve is nil CurveList数字下标越界
                print("deleteCurve is nil")
                self.frontStep=self.curveList.count
                sender.value=Double(self.curveList.count)
            }
        }
    }else{//stepper for"-"button
        print("stepper for - button")
        if(self.curveList.count != 0){//curveList is not nil
            print("curveList is not nil")
            self.deleteCurveList.append(self.curveList.remove(at: self.curveList.count-1))
            self.delteCurveColour.append(self.curveListColor.remove(at: self.curveListColor.count-1))
            if(self.curveList.count==0){//after remove curveList is nil
                print("after remove curveList is nil")
                self.frontStep=1
                sender.value=1
            }else{
                self.frontStep=curveList.count
                sender.value=Double(curveList.count)
            }
            
        }else{//curveList is nil
            print("curveList is nil")
            self.frontStep=1
            sender.value=1
        }
        
    }
    print("result sender value is:\(sender.value)")
    print("result curveList value is:\(curveList.count)")
    print("result frontStep is\(self.frontStep)")
    print("over")
    self.setNeedsDisplay()
 }
  
  override func draw(_ rect: CGRect) {
    UIColor.white.set()
    UIRectFill(rect)
    color.set()
    for (index,path) in curveList.enumerated() {
      curveListColor[index].set()
      
      path.stroke()
    }
    
    color.set()
    if(self.dashed){
        self.currentPath?.setLineDash([10,2], count: 2, phase: 1)
    }
    self.currentPath?.stroke()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first!
    let pt = touch.location(in: self)
    self.currentPath = UIBezierPath()
    self.currentPath!.lineWidth = CGFloat(self.lineWidth)
    self.currentPath!.move(to: pt)
    self.hasMoved = false;
    self.curveListColor.append(self.color)
    self.setNeedsDisplay()
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first!
    let pt = touch.location(in: self)
    
    self.currentPath!.addLine(to: pt)
    
    self.hasMoved = true
    self.setNeedsDisplay()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first!
    let pt = touch.location(in: self)
    
    if !self.hasMoved {
      self.currentPath = nil
      return
    }
    
    self.currentPath!.addLine(to: pt)
    self.curveList.append(self.currentPath!)
    
    self.currentPath = nil
    
    self.setNeedsDisplay()
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.currentPath = nil
  }
  

}
