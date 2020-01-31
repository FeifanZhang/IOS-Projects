//
//  CustomizeCell.swift
//  Sw-TableEdit
//
//  Created by 张非凡 on 10/31/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import Foundation
import UIKit

class CustomizeCell:UITableViewCell{
    var deletionLock:Bool
    var movementLock:Bool
    var deletionStatement:UILabel?
    var movementStatement:UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.deletionLock=false
        self.movementLock=false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        self.deletionLock=false
        self.movementLock=false
        super.init(coder: aDecoder)
        setUpUI()
        
    }
    
    func setDeletionLock(deletionLock:Bool){
        self.deletionLock = deletionLock
        if self.deletionLock{
            self.deletionStatement?.textColor=UIColor.red
        }else{
            self.deletionStatement?.textColor=UIColor.green
        }
    }
    
    func setMovementLock(movementLock:Bool){
        self.movementLock=movementLock
        if self.movementLock{
            self.movementStatement?.textColor=UIColor.red
        }else{
            self.movementStatement?.textColor=UIColor.green
        }
    }
    
    func setUpUI(){
        self.deletionStatement=UILabel.init()
        self.deletionStatement?.backgroundColor=UIColor.clear;
        //frame的minY是指frame在Y轴上的起始位置，maxY是指Y轴的终止位置 x同理
        self.deletionStatement?.frame=CGRect(x:self.frame.maxX/2,y:(self.textLabel?.frame.minY)!,width:self.frame.maxY,height:self.frame.maxY)
        self.deletionStatement?.text = "D"
        self.deletionStatement?.font = UIFont.systemFont(ofSize: 40)
        self.deletionStatement?.textColor=UIColor.green
        self.contentView.addSubview(self.deletionStatement!)
        
        self.movementStatement=UILabel.init()
        self.movementStatement?.backgroundColor=UIColor.clear;
        self.movementStatement?.frame=CGRect(x:self.frame.maxX/2+self.frame.maxY,y:(self.textLabel?.frame.minY)!,width:self.frame.maxY,height:self.frame.maxY)
        self.movementStatement?.text = "M"
        self.movementStatement?.font = UIFont.systemFont(ofSize: 40)
        self.movementStatement?.textColor=UIColor.green
        self.contentView.addSubview(self.movementStatement!)
    }
    
}
