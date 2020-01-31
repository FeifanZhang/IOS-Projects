//
//  BounceView.swift
//  Assign3
//
//  Created by Steven Senger on 9/19/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class BounceView: UIView {
    var color = UIColor.white
    var ballColor=UIColor.white
    
    var particles = [Particle]()
    var addingParticles = false
    var lastTouchPoint = CGPoint()
    var firstTouchPoint = CGPoint()
    
    func modifyColor(){
        self.setNeedsDisplay()
    }
    
    func modifyParticlesGravity(gravity:CGFloat){
        particles[0].gravity=gravity
    }
    
    func bounceBetweenBalls(bottom: CGFloat, top: CGFloat, right: CGFloat, left: CGFloat,gravity:CGFloat,damping:CGFloat){
        var changeV=[Bool]()
        while changeV.count<particles.count{
            changeV.append(true)
        }
        for(indexA, particleA) in particles.enumerated(){
            for indexB in indexA+1..<particles.count{
                //two ball hit
                if pow(particleA.position.x-particles[indexB].position.x,2)+pow(particleA.position.y-particles[indexB].position.y,2)<=pow(particleA.radius,2){
                    //A above the B
                    if(particleA.position.y<particles[indexB].position.y){
                        particleA.position.y += (particleA.radius)/2
                        particles[indexB].position.y -= (particles[indexB].radius)/2
                    }else{
                        particleA.position.y -= (particleA.radius)/2
                        particles[indexB].position.y += (particles[indexB].radius)/2
                    }
                    //A is on the left side of B
                    if(particleA.position.x<particles[indexB].position.x){
                        particleA.position.x += (particleA.radius)/2
                        particles[indexB].position.x -= (particles[indexB].radius)/2
                    }else{
                        particleA.position.x -= (particleA.radius)/2
                        particles[indexB].position.x += (particles[indexB].radius)/2
                    }
                    
                    if(changeV[indexA]==true){
                        particleA.velocity.x = -particleA.velocity.x
                        particleA.velocity.y = -particleA.velocity.y
                        changeV[indexA]=false
                    }
                    if(changeV[indexB]==true){
                        particles[indexB].velocity.x = -particles[indexB].velocity.x
                        particles[indexB].velocity.y = -particles[indexB].velocity.y
                        changeV[indexB]=false
                    }
                }
            }
        }
        for (index,particle) in particles.enumerated() {
            particle.updatePosition(bottom:bottom,top:top,right:right,left:left,gravity:gravity,damping:damping)
            if particle.remove{
                if(index<particles.count){self.particles.remove(at: index)}
            }
        }
    }
    
    func updateParticles(bottom:CGFloat,top:CGFloat,right:CGFloat,left:CGFloat,gravity:CGFloat,damping:CGFloat) {
        
        if addingParticles {
            addParticle(at: lastTouchPoint, with: CGPoint(x: firstTouchPoint.x-lastTouchPoint.x, y: firstTouchPoint.y-lastTouchPoint.y))
        }
        bounceBetweenBalls(bottom:bottom,top:top,right:right,left:left,gravity:gravity,damping:damping)
        
        self.setNeedsDisplay()
    }
    
    func addParticle(at pt: CGPoint, with vel: CGPoint) {
        if particles.count > 300 { return }
        let particle = Particle()
        particle.position = pt
        particle.velocity = vel
        particles.append(particle)
        print("postition is \(particle.position)")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPoint = touches.first!.location(in: self)
        firstTouchPoint=touches.first!.location(in: self)
        addingParticles = true
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pt = touches.first!.location(in: self)
        firstTouchPoint=lastTouchPoint
        lastTouchPoint = pt
        addingParticles = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        addingParticles = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        addingParticles = false
    }
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(self.color.cgColor)
        context?.fill(rect)
        context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
        context?.setLineWidth(3.0)
        context?.stroke(rect)
        
        self.ballColor.set()
        for particle in self.particles {
            particle.draw()
        }
    }
}
