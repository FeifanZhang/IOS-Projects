//
//  ViewController.swift
//  assign 2
//
//  Created by 张非凡 on 9/20/18.
//  Copyright © 2018 张非凡. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var keyField: UITextField!
    @IBOutlet var valueField: UITextField!
    
    
    
    var dict=[String:String]()
    var keyArray:[String]=[]
    var pointer:Int=0
    
    @IBAction func enter(sender: UIButton){
        if (!(keyField.text == nil) && !(valueField.text == nil) && keyArray.index(of: keyField.text!)==nil){
            if(keyArray.isEmpty){
                dict[keyField.text!]=valueField.text
                keyArray.append(keyField.text!)
                print(pointer)
                
            }else{
                dict[keyField.text!]=valueField.text
                //keyArray.append(keyField.text!)
                pointer+=1
                keyArray.insert(keyField.text!, at: pointer)
                print(keyArray)
            }
            
            keyField.placeholder=keyField.text
            valueField.placeholder=valueField.text
            keyField.text=nil
            valueField.text=nil
        }
    }
    
    @IBAction func clear(sender: UIButton){
        for key in keyArray{
            dict.removeValue(forKey:key)
        };keyArray.removeAll()
        pointer=0
        keyField.text=nil
        valueField.text=nil
        keyField.placeholder=nil
        valueField.placeholder=nil
    }
    
    @IBAction func prev(sender: UIButton){
        if(!keyArray.isEmpty && pointer>0){
            pointer-=1
            keyField.text=keyArray[pointer]
            valueField.text=dict[keyArray[pointer]]
            keyField.placeholder=nil
            valueField.placeholder=nil
        }
        if(!keyArray.isEmpty && pointer==0){
            keyField.text=keyArray[pointer]
            valueField.text=dict[keyArray[pointer]]
            keyField.placeholder=nil
            valueField.placeholder=nil
        }
    }
    
    @IBAction func next(sender: UIButton){
        if(!keyArray.isEmpty&&pointer<=keyArray.count-2){
            pointer+=1
            keyField.text=keyArray[pointer]
            valueField.text=dict[keyArray[pointer]]
            keyField.placeholder=nil
            valueField.placeholder=nil
        }else{
            
        }
    }
    
    @IBAction func erase(sender:UIButton){
        if(!(keyField.text==nil) && !(valueField.text==nil) && !(keyArray.isEmpty)){
            for (index,key) in keyArray.enumerated(){
                if(key==keyField.text){
                    keyArray.remove(at: index)
                    dict.removeValue(forKey:key)
                    if(pointer>=keyArray.count){
                        pointer=keyArray.count-1
                    }
                }
            }
            if(!(keyArray.isEmpty)){
                keyField.text=keyArray[pointer]
                valueField.text=dict[keyArray[pointer]]
            }
        }
        if(keyArray.isEmpty){
            keyField.text=nil
            valueField.text=nil
        }
        keyField.placeholder=nil
        valueField.placeholder=nil
    }
    
    @IBAction func lookup(sender:UIButton){
        if(!(keyField.text==nil)){
            if(!(keyArray.isEmpty)){
                valueField.text=dict[keyField.text!]
                valueField.placeholder=nil
                if(!(keyArray.index(of: keyField.text!)==nil)){
                    pointer=keyArray.index(of: keyField.text!)!
                }
                print(pointer)
            }
        }
    }
    
    @IBAction func save(sender:UIButton){
        UserDefaults.standard.set(dict, forKey: "TheAppDict")
        UserDefaults.standard.set(keyArray, forKey: "TheAppKeyArray")
        print(keyArray)
        keyField.placeholder=keyField.text
        valueField.placeholder=valueField.text
        keyField.text=nil
        valueField.text=nil
    }
    
    @IBAction func load(sender:UIButton){
        dict = (UserDefaults.standard.object(forKey: "TheAppDict") as? [String : String])!
        keyArray = (UserDefaults.standard.object(forKey: "TheAppKeyArray") as! [String])
        if(!(dict.isEmpty) && !(keyArray.isEmpty)){
            pointer=0
            keyField.text=keyArray[pointer]
            valueField.text=dict[keyArray[pointer]]
        }else{
            keyField.text=nil
            valueField.text=nil
        }
        keyField.placeholder=nil
        valueField.placeholder=nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

