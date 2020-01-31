//
//  PegView.swift
//  Sw-PegGame
//
//  Created by Steven Senger on 11/3/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class PegView: UIControl,CAAnimationDelegate{
    //先执行animate 在执行draw
    var index: Int = 0
    //false执行draw,true执行animate
    var ifInit=false
    var ifRemove=false
    var lastCenter:CGPoint!
    override var center: CGPoint{
        willSet{
            lastCenter=center
        }
        didSet{
            animate(from: CGPoint(x:lastCenter.x-center.x, y: lastCenter.y-center.y), to: CGPoint(x: 0, y: 0))
        }
    }

    override func draw(_ rect: CGRect) {
        if ifInit{
            UIColor.clear.set()
            UIBezierPath(ovalIn: rect).fill()
        }else{
            UIColor(red: 0.8, green: 0.7, blue: 0.3, alpha: 1.0).set()
            UIBezierPath(ovalIn: rect).fill()
            ifInit=true
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if ifRemove{
            self.removeFromSuperview()
            self.setNeedsDisplay()
        }
    }
    
    func animate(from:CGPoint,to:CGPoint){
        if ifInit{
            //需要把上一个layer的动画清空，否则第二次执行动画时，会有图层的叠加
            self.layer.sublayers=[]
            //通过setNeedsDisplay的方法来调用draw方法
            self.setNeedsDisplay()
            let lineLayer=CAShapeLayer()
            lineLayer.path=UIBezierPath(ovalIn: CGRect(x:0,y:0,width:32.0,height:32.0)).cgPath
            lineLayer.fillColor=UIColor(red: 0.8, green: 0.7, blue: 0.3, alpha: 1.0).cgColor
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = from
            animation.toValue = to
            animation.duration = 0.4
            animation.isRemovedOnCompletion = false
            //想要设置delegate就要先让类继承CAanimationDelegate类
            //在addlayer之前就要加上
            animation.delegate=self
            lineLayer.add(animation, forKey: "move")
            layer.addSublayer(lineLayer)
        }
    }
}
