//
//  SwishGestureRecognizer.swift
//  Sw-SwishGesture
//
//  Created by Steven Senger on 11/19/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class SwishGestureRecognizer: UIGestureRecognizer {
  
  let MIN_MOVEMENT = CGFloat(25.0)
  
  enum SwishDirections { case SwishLeft, SwishRight, SwishUp, SwishDown }
  
  var requiredDirections = Set<SwishDirections>()
  var detectedDirections = Set<SwishDirections>()
  var requiredAccuracy = CGFloat(0)
  var startPt = CGPoint()
  var turnPt = CGPoint()
  var endPt = CGPoint()
  
  var hasTurned = false
  var swishVec = CGPoint()
  var hasSwishVec = false
  var minProject = CGFloat(0)
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
    detectedDirections.removeAll()
    hasTurned=false
    startPt=(touches.first?.location(in: self.view))!
    turnPt=startPt
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
    if turnPt==startPt{
        turnPt=(touches.first?.location(in: self.view))!
    }else if !hasTurned{//turnPt没有被赋值到拐点
        let pathPt=(touches.first?.location(in: self.view))!
        let turnToPathVec = turnPt-pathPt
        let turnToStartVec=turnPt-startPt
        let cos=turnToPathVec.dot(turnToStartVec)/(turnToStartVec.magnitude()*turnToPathVec.magnitude())
        turnPt=pathPt
        let pathToStartVec=pathPt-startPt
        if acos(cos)*180/CGFloat(Double.pi)<90 && pathToStartVec.magnitude()>=MIN_MOVEMENT{//角度超出了精度值 且长度大于MIN_MOVEMENT
            hasTurned=true
            detectedDirections.insert(vectorDirection(startPt-turnPt))
        }
    }
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
    endPt=(touches.first?.location(in: self.view))!
    let turnToStartVec = turnPt-startPt
    let turnToEndVec = turnPt-endPt
    let cos = turnToStartVec.dot(turnToEndVec)/(turnToStartVec.magnitude()*turnToEndVec.magnitude())
    if hasTurned && turnToEndVec.magnitude()>turnToStartVec.magnitude() && acos(cos)*180/CGFloat(Double.pi)<90{
        let gesture=vectorDirection(turnToEndVec)
        detectedDirections.insert(gesture)
        if detectedDirections.contains(SwishDirections.SwishDown) && detectedDirections.contains(SwishDirections.SwishUp){
            detectedDirections.remove(gesture)
        }else if detectedDirections.contains(SwishDirections.SwishLeft) && detectedDirections.contains(SwishDirections.SwishRight){
            detectedDirections.remove(gesture)
        }
    }else { detectedDirections.removeAll() }
    if requiredDirections==detectedDirections{
        self.state = .recognized//此状态会调取一次绑定函数(In ViewDidLoad, addTarget(selctor:))然后恢复至.possible状态.
    }
    else{//不符合条件，直接failed,不会调用绑定函数，如不进行failed的话，viewController设置的手势会由上至下依次执行(print出的requiredDirections也只有最后一个init的手势的)，如果直接failed的话，就相当于直接跳过。
        self.state = .failed
    }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
  }
    
    // v: from start to end
  func vectorDirection(_ v: CGPoint) -> SwishDirections {
    if v.x < 0 {
        return abs(v.x) > abs(v.y) ? SwishDirections.SwishRight : v.y > 0 ? SwishDirections.SwishUp : SwishDirections.SwishDown
    }else{
      return abs(v.x) > abs(v.y) ? SwishDirections.SwishLeft: v.y > 0 ? SwishDirections.SwishUp : SwishDirections.SwishDown
    }
  }
}
