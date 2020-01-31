//
//  AttributeViewController.swift
//  Assign4
//
//  Created by 张非凡 on 10/12/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit



class AttributeViewController: UIViewController {
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var widthSlider: UISlider!
    @IBOutlet var widthLabel:UILabel!
    @IBOutlet var dashedSwitch:UISwitch!
    
    
    @IBAction func modifyWidthLabel(sender:UISlider){
        widthLabel.text = String(format:"%.2f",sender.value)
    }
    
    var red:Float=0.0
    var green:Float=0.0
    var blue:Float=0.0
    var width:Float = 1.0
    var dashed:Bool=false
    var curveList = [UIBezierPath]()
    var curveListColor=[UIColor]()
    var stepStepper:UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.redSlider.value = self.red
        self.greenSlider.value = self.green
        self.blueSlider.value = self.blue
        self.widthSlider.value = self.width
        self.widthLabel.text = String(self.width)
        self.dashedSwitch.isOn = self.dashed
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        (segue.destination as! MainViewController).red = Float(self.redSlider.value)
        (segue.destination as! MainViewController).green = Float(self.greenSlider.value)
        (segue.destination as! MainViewController).blue = Float(self.blueSlider.value)
        (segue.destination as! MainViewController).curveList=self.curveList
        (segue.destination as! MainViewController).dashed=self.dashedSwitch.isOn
        (segue.destination as! MainViewController).curveListColor = self.curveListColor
        (segue.destination as! MainViewController).width = Float(self.widthSlider.value)
    }
    
    
}
