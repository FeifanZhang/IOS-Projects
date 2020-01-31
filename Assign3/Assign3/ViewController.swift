//
//  ViewController.swift
//  Assign3
//
//  Created by Steven Senger on 9/19/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dampingValue=CGFloat(1)
    var gravityValue=CGFloat(2.5)
    
    var red:Float=0.5
    var green:Float=0.5
    var blue:Float=0.5
    
    var redBall:Float=1
    var greenBall:Float=1
    var blueBall:Float=0
    @IBAction func gravity(_ sender:UISlider){
        if(sender.value != nil){
            gravityValue=CGFloat(sender.value)*5
        }
        
    }
    
    @IBAction func damping(_ sender:UISlider){
        if(sender.value != nil)
        {
            dampingValue=CGFloat(sender.value)*2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = Timer(timeInterval: 1/30.0, repeats: true, block: {(v) -> Void in (self.view as! BounceView).updateParticles(bottom:self.view.frame.origin.y + self.view.frame.size.height, top:self.view.frame.origin.y,right:self.view.frame.origin.x+self.view.frame.size.width,left:self.view.frame.origin.x,gravity:self.gravityValue,damping:self.dampingValue)})
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
        (self.view as! BounceView).color=UIColor(red: CGFloat(self.red), green: CGFloat(self.green), blue: CGFloat(self.blue), alpha: 1.0)
        (self.view as! BounceView).ballColor=UIColor(red: CGFloat(self.redBall), green: CGFloat(self.greenBall), blue: CGFloat(self.blueBall), alpha: 1.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! SettingViewController).red = self.red
        (segue.destination as! SettingViewController).green = self.green
        (segue.destination as! SettingViewController).blue = self.blue
        (segue.destination as! SettingViewController).redBall=self.redBall
        (segue.destination as! SettingViewController).greenBall=self.greenBall
        (segue.destination as! SettingViewController).blueBall=self.blueBall
        
    }
    
    
}

