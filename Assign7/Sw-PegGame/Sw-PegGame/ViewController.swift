//
//  ViewController.swift
//  Sw-PegGame
//
//  Created by Steven Senger on 11/3/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var fieldView: UIView!
  var pascalLayout: PascalLayout?
  
  var pegs = [Int:PegView]()
  var lastHole: HoleView?
    
  @objc func holeTouched(_ sender: HoleView) {
    if pegs[sender.index] != nil { return }
    if lastHole != nil {
      lastHole!.active = false
      lastHole!.setNeedsDisplay()
    }
    sender.active = !sender.active
    lastHole = sender
    sender.setNeedsDisplay()
  }
    
    @IBAction func reset(){
        let pegSize = fieldView.bounds.size.width / 10.0
        var indexList=[Int]()
        //顶端hole中有小球,则清空
        if pegs[0] != nil{
            pegs[0]!.removeFromSuperview()
            pegs[0] = nil
        }
        for index in 1...14{
            if pegs[index]==nil{
                let peg = PegView(frame: CGRect(x: 0, y: 0, width: pegSize, height: pegSize))
                peg.addTarget(self, action: #selector(self.pegTouched), for: UIControl.Event.touchUpInside)
                peg.isOpaque = false
                peg.layer.zPosition = 1
                peg.center=CGPoint(x: fieldView.bounds.size.width/2, y: 0)
                peg.index = index
                fieldView.addSubview(peg)
                pegs[index] = peg
                indexList.append(index)
                peg.ifInit=true
            }
        }
        for index in indexList{
            pegs[index]!.center = pascalLayout!.coordForIndex(index)
        }
    }
    
  @objc func pegTouched(_ peg: PegView) {
    if lastHole == nil || lastHole!.active == false { return }
    if !pascalLayout!.index(peg.index, canJumpTo: lastHole!.index) { return }
    let midIndex = pascalLayout!.indexBetween(peg.index, and: lastHole!.index)
    if pegs[midIndex] == nil { return }
    pegs[peg.index] = nil
    peg.center = lastHole!.center
    peg.index = lastHole!.index
    pegs[peg.index] = peg
    lastHole!.active = false
    lastHole?.setNeedsDisplay()
    lastHole = nil
    let x=CGFloat((pascalLayout?.indices[midIndex].1)!)-CGFloat((pascalLayout?.indices[peg.index].1)!)
    let y=CGFloat((pascalLayout?.indices[peg.index].0)!)-CGFloat((pascalLayout?.indices[midIndex].0)!)
    let midPegPath=CGPoint(x: x, y: y)
    self.pegs[midIndex]?.ifRemove=true
    self.pegs[midIndex]?.center=CGPoint(x:midPegPath.x*600,y:midPegPath.y*600)
    pegs[midIndex] = nil
  }
  
  override func viewDidLayoutSubviews() {
    if pascalLayout != nil { return }
    
    let width = fieldView.bounds.size.width
    let scale = width / 6.0
    let mid = width / 2.0
    
    pascalLayout = PascalLayout(base: CGPoint(x: mid, y: 1.2 * scale), scale: scale)
    
    let holeSize = width / 20.0
    for i in 0...14 {
      let hole = HoleView(frame: CGRect(x: 0, y: 0, width: holeSize, height: holeSize))
      hole.addTarget(self, action: #selector(self.holeTouched), for: UIControl.Event.touchUpInside)
      hole.isOpaque = false
      hole.layer.zPosition = 0
      hole.center = pascalLayout!.coordForIndex(i)
      hole.index = i
      hole.active = false
      fieldView.addSubview(hole)
    }
    
    let pegSize = width / 10.0
    for i in 1...14 {
      let peg = PegView(frame: CGRect(x: 0, y: 0, width: pegSize, height: pegSize))
      peg.addTarget(self, action: #selector(self.pegTouched), for: UIControl.Event.touchUpInside)
      peg.isOpaque = false
      peg.layer.zPosition = 1
      peg.center=CGPoint(x: fieldView.bounds.size.width/2, y: 0)
      peg.index = i
      fieldView.addSubview(peg)
      pegs[i] = peg
      peg.ifInit=true
    }
    
    for index in 1...14{
        pegs[index]!.center = pascalLayout!.coordForIndex(index)
    }
  }
}

