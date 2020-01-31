//
//  CGPoint-Vector.swift
//  Sw-SwishGesture
//
//  Created by Steven Senger on 11/19/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

extension CGPoint {
  static func + (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }
  
  static func += (_ lhs: inout CGPoint, _ rhs: CGPoint) {
    lhs = lhs + rhs
  }
  
  static func - (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
  }
  
  static func -= (_ lhs: inout CGPoint, _ rhs: CGPoint) {
    lhs = lhs - rhs
  }
  
  static func * (_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
  }
  
  static func *= (_ lhs: inout CGPoint, rhs: CGFloat) {
    lhs = lhs * rhs
  }
  
  static func / (_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
  }
  
  static func /= (_ lhs: inout CGPoint, rhs: CGFloat) {
    lhs = lhs / rhs
  }
  
  public func dot (_ v: CGPoint) -> CGFloat {
    return self.x * v.x + self.y * v.y
  }
  
  public func project(_ p: CGPoint) -> CGFloat {
    return self.dot(p) / p.dot(p)
  }
  //length of the vec
  public func magnitude() -> CGFloat {
    return sqrt((x * x) + (y * y))
  }
  
  public func magSqrd() -> CGFloat {
    return (x * x) + (y * y)
  }
  
  public func normalize() -> CGPoint {
    return self / self.magnitude()
  }
}


