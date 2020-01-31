//
//  PascalLayout.swift
//  Sw-PegGame
//
//  Created by Steven Senger on 11/3/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

func sum(_ v: Int) ->Int {
  var v = v
  var ret = v
  v -= 1
  while v > 0 {
    ret += v
    v -= 1
  }
  return ret
}

class PascalLayout: NSObject {
  
                      // first is row, second is position in row
  var indices = [                   (0,0),                 //          0
                                 (1,0), (1,1),             //        1   2
                             (2,0), (2,1), (2,2),          //      3   4   5
                          (3,0), (3,1), (3,2), (3,3),      //    6   7   8   9
                       (4,0), (4,1), (4,2), (4,3), (4,4)   //  10  11  12  13  14
                ]
  
  var base = CGPoint()
  var scale: CGFloat = 0.0
  
  init(base: CGPoint, scale: CGFloat) {
    self.base = base
    self.scale = scale
    super.init()
  }
  //被点击的小球是否可以移动
  func index(_ indexA: Int, canJumpTo indexB: Int) -> Bool {
    if indexA < 0 || indexA > 14 || indexB < 0 || indexB > 14 { return false }
    
    return ( (indices[indexA].0 == indices[indexB].0 + 2)
              && (indices[indexA].1 == indices[indexB].1 || indices[indexA].1 == indices[indexB].1 + 2))
        || ( (indices[indexA].0 == indices[indexB].0)
              && (indices[indexA].1 == indices[indexB].1 + 2 || indices[indexB].1 == indices[indexA].1 + 2))
        || ( (indices[indexB].0 == indices[indexA].0 + 2)
              && (indices[indexB].1 == indices[indexA].1 || indices[indexB].1 == indices[indexA].1 + 2))
  }
  
  func indexBetween(_ indexA: Int, and indexB: Int) -> Int {
    if indexA < 0 || indexA > 14 || indexB < 0 || indexB > 14 { return -1 }

    let midRow = (indices[indexA].0 + indices[indexB].0) / 2
    let midPos = (indices[indexA].1 + indices[indexB].1) / 2
    return sum(midRow) + midPos
  }
  
  func coordForIndex(_ index: Int) -> CGPoint {
    if index < 0 || index > 14 { return CGPoint(x: -1, y: -1) }
    let x = base.x - CGFloat(indices[index].0) * 0.5 * scale + CGFloat(indices[index].1) * scale
    let y = base.y + CGFloat(indices[index].0) * 0.86225 * scale
    return CGPoint(x: x, y: y)
  }
  
}
