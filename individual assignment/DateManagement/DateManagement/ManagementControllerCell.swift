//
//  ManagementControllerCell.swift
//  DateManagement
//
//  Created by 张非凡 on 11/26/18.
//  Copyright © 2018 张非凡. All rights reserved.
//

import Foundation
import UIKit

class ManagementControllerCell:UITableViewCell{
    var setUpAlarm:Bool{
        didSet{
            if self.setUpAlarm{
                self.detailTextLabel!.textColor=UIColor.green
                self.detailTextLabel?.text="✓"
            }else{
                self.detailTextLabel!.textColor=UIColor.red
                self.detailTextLabel?.text="Haven't finish yet."
            }
        }
    }
    var eventName:UILabel?
    var detail:UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.setUpAlarm=false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.setUpAlarm=false
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    func setUpUI(){
        self.eventName=UILabel.init()
        self.eventName?.backgroundColor=UIColor.clear;
        //frame的minY是指frame在Y轴上的起始位置，maxY是指Y轴的终止位置 x同理
        self.eventName?.frame=CGRect(x:(self.textLabel?.frame.maxX)!+90,y:self.frame.minY,width:self.frame.maxX/3*2,height:40)
        self.eventName?.font = UIFont.systemFont(ofSize: 23)
        self.eventName?.textColor=UIColor.white
        self.contentView.addSubview(self.eventName!)
        
        self.detail=UILabel.init()
        self.detail?.backgroundColor=UIColor.clear;
        //frame的minY是指frame在Y轴上的起始位置，maxY是指Y轴的终止位置 x同理
        self.detail?.frame=CGRect(x:self.frame.maxX/2,y:(self.detailTextLabel?.frame.midY)!,width:self.frame.maxX/2,height:60)
        self.detail?.font = UIFont.systemFont(ofSize: 17)
        self.detail?.textColor=UIColor.white
        //自动换行
        self.detail?.lineBreakMode=NSLineBreakMode.byWordWrapping
        self.detail?.numberOfLines=0
        self.contentView.addSubview(self.detail!)
        
        self.textLabel?.font=UIFont.systemFont(ofSize: 18)
        self.textLabel?.textColor=UIColor.white
        self.detailTextLabel?.font=UIFont.systemFont(ofSize: 13)
    }
}

