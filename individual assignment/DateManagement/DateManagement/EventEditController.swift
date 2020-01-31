//
//  EventEditController.swift
//  DateManagement
//
//  Created by 张非凡 on 11/27/18.
//  Copyright © 2018 张非凡. All rights reserved.
//

import UIKit

class EventEditController: UIViewController{
    
    var singleEvent=[String:String]()
    var updateIndexPath=IndexPath()
    var management:ManagementController?
    
    @IBOutlet var fromButton:UIButton!{
        didSet{
            if fromButton.isSelected{
                fromButton.backgroundColor=UIColor.white
                //set title的颜色要用这个而不是 titleLabel.setColor
                fromButton.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
            }else{
                fromButton.backgroundColor=UIColor.darkGray
                fromButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            }
        }
    }
    @IBOutlet var toButton:UIButton!{
        didSet{
            if toButton.isSelected{
                toButton.backgroundColor=UIColor.white
                toButton.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
            }else{
                toButton.backgroundColor=UIColor.darkGray
                //set title的颜色要用这个而不是 titleLabel.setColor
                toButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            }
        }
    }
    @IBOutlet var timeDatePicker:UIDatePicker!
    @IBOutlet var nameTextView:UITextField!
    @IBOutlet var detailTextView:UITextView!
    
    override func viewWillDisappear(_ animated: Bool) {
        self.management!.updateEventData(singleEvent: singleEvent, updateIndexPath: updateIndexPath)
        self.management!.tableView.reloadRows(at: [updateIndexPath], with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toButton.setTitle(singleEvent["to"], for: UIControl.State.normal)
        fromButton.setTitle(singleEvent["from"], for: UIControl.State.normal)
        nameTextView.text=singleEvent["eventName"]
        detailTextView.text=singleEvent["detail"]
        let date=Date()
        timeDatePicker.setDate(date, animated: true)
        let saveUIBarButtonItem=UIBarButtonItem.init(title:"save",style: .done, target: self, action: #selector(saveSingleEvent))//selector是构造方法与OC的SEL类型对应,内部参数是方法名称
        saveUIBarButtonItem.setTitleTextAttributes([NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)],for: .normal)
        self.navigationItem.rightBarButtonItem = saveUIBarButtonItem
    }
    
    //单击事件通过设置select属性来确定button是否被选 删除doubletap
    //除了初始化label的值和最后的save方法，其他的情况界面显示，修改数据和singleEvent无关
    @IBAction func touchDownButton(_sender:UIButton){
        //该button之前没有被选中
        if _sender.isSelected==false{
            let dateFormatter=DateFormatter()
            //Date类型的使用：
            //https://www.jianshu.com/p/a6275cc54e04
            //by the way 简书大法好 ！
            dateFormatter.dateFormat="HH:mm"
            timeDatePicker.setDate(dateFormatter.date(from: (_sender.titleLabel?.text)!)!, animated: true)
            if _sender.restorationIdentifier=="fromButton"{
                toButton.isSelected=false
                fromButton.isSelected=true
            }else{
                toButton.isSelected=true
                fromButton.isSelected=false
            }
        }else{//该button之前被选中
            let dateFormatter=DateFormatter()
            dateFormatter.dateFormat="HH:mm"
            _sender.setTitle(dateFormatter.string(from: timeDatePicker.date), for: UIControl.State.normal)
            print(_sender.titleLabel?.text)
            print(timeDatePicker.date)
            if _sender.restorationIdentifier=="fromButton"{
                fromButton.isSelected=false
            }else{
                toButton.isSelected=false
            }
        }
    }
    
    @objc func saveSingleEvent(){
        singleEvent["from"]=fromButton.titleLabel?.text
        singleEvent["to"]=toButton.titleLabel?.text
        singleEvent["eventName"]=nameTextView.text
        singleEvent["detail"]=detailTextView.text
        self.title=nameTextView.text
    }
    
}
