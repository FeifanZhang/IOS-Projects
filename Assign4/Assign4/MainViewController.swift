//
//  ViewController.swift
//  Assign4
//
//  Created by Steven Senger on 9/29/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
  //@IBOutlet var stepStepper:UIStepper!
    
  var colorPatch: ColorPatchView!
    
  var red:Float=0.0
  var green:Float=0.0
  var blue:Float=0.0
  var width:Float=1.0
  var dashed:Bool=false
    
  var curveList = [UIBezierPath]()
  var curveListColor=[UIColor]()
  
    
  @IBOutlet var stepStepper:UIStepper!
    
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    (self.view as! DrawView).curveList=self.curveList
    (self.view as! DrawView).color=UIColor(red: CGFloat(self.red), green: CGFloat(self.green), blue: CGFloat(self.blue), alpha: 1.0)
    (self.view as! DrawView).curveListColor=self.curveListColor
    (self.view as! DrawView).lineWidth=self.width
    (self.view as! DrawView).dashed=self.dashed
    if(curveList.count != 0){
        (self.view as! DrawView).frontStep=self.curveList.count
    }else{
        (self.view as! DrawView).frontStep=1
    }
    
    
    //self.frontStep=self.curveList.count
    
  }
    
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! AttributeViewController).red = self.red
        (segue.destination as! AttributeViewController).green = self.green
        (segue.destination as! AttributeViewController).blue = self.blue
        (segue.destination as! AttributeViewController).width = self.width
        (segue.destination as! AttributeViewController).dashed = self.dashed
        (segue.destination as! AttributeViewController).stepStepper = self.stepStepper
        (segue.destination as! AttributeViewController).curveList = (self.view as! DrawView).curveList
        (segue.destination as! AttributeViewController).curveListColor = (self.view as! DrawView).curveListColor
  }


}

