//
//  Particle.swift
//  Assign3
//
//  Created by Steven Senger on 9/19/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class Particle: NSObject {
    
    var position = CGPoint()
    var velocity = CGPoint()
    var radius = CGFloat(-5)
    var damping=CGFloat(1)
    var particleTimer:Timer!
    var gravity = CGFloat(2.5)
    var remove = false
    
    
    func touchTheBottom(bottom:CGFloat){
        //bounce back
        velocity.y = -velocity.y
        position.y=bottom+radius
        //touch the bottom and the V is 0
        if (-velocity.y <= 5){
            position.y=bottom+radius
            velocity.y=0
            particleTimer=Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block:{(v) -> Void in self.remove=true})
            return
        }
    }
    
    func particleMovement(){
        //damping on X
        if velocity.x>0{
            velocity.x = velocity.x - damping
        }else{
            velocity.x = velocity.x + damping
        }
        //gravity and damping on Y
        if velocity.y>0{
            velocity.y += gravity - damping
        }else{
            velocity.y += gravity + damping
        }
    }
    
    
    
    func updatePosition(bottom:CGFloat,top:CGFloat,right:CGFloat,left:CGFloat,gravity:CGFloat,damping:CGFloat) {
        self.gravity=gravity
        self.damping=damping
        // Still on bottom
        if (position.y==bottom+radius)&&(velocity.y==0){return}
        //move at the original velocity
        position.x += velocity.x
        position.y += velocity.y
        //touch the bottom(Y)
        if position.y+velocity.y>=bottom+radius{
            touchTheBottom(bottom: bottom)
        }
        //hit the floor
        if(position.y+velocity.y<=top-radius){
            velocity.y = -velocity.y
            position.y = top-radius
        }
        //touch the sides of the screen
        if position.x+velocity.x>=right+radius{
            velocity.x = -velocity.x
            position.x=right+radius
        }
        if position.x+velocity.x<=left-radius{
            velocity.x = -velocity.x
            position.x=left-radius
        }else{particleMovement()}
    }
    
    func draw() {
        
        let rect = CGRect(x: position.x, y: position.y, width: 0, height: 0).insetBy(dx: radius, dy: radius)
        let tail = UIBezierPath()
        tail.move(to: position)
        tail.addLine(to: CGPoint.init(x: position.x-velocity.x, y: position.y-velocity.y))
        tail.lineWidth = CGFloat(4.0)
        tail.stroke()
        UIBezierPath(ovalIn: rect).fill()
    }
}
