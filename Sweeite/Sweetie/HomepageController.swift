//
//  ViewController.swift
//  DateManagement
//
//  Created by 张非凡 on 11/25/18.
//  Copyright © 2018 张非凡. All rights reserved.
//

import UIKit
import UserNotifications


class HomepageController: UIViewController{
    var allData = ["livingRoom":["打扫客厅":"livingRoomCleaning",],
                   "canteen":["杂物一览":"sundries"],
    "restRoom":["备用厕纸":"toiletPaperBackUp","威猛先生洁厕":"closeToolCleanUp","打扫洗手池":"washBasinCleanUp"],
                   "smallBedRoom":["窗户":"windowInstalling"],
                   "bigBedRoom":["衣服的摆放":"url"],
                   "darkRoom":["帽子":"url"],
                   "balcony":["阳台漏水":"balconyLeaking"],
                   "kitchen":["调料摆放":"seasoningPlace","清洁灶台":"hearthCleaning","锅铲位置":"url"],
                   "outside":["买菜":"url","买肉":"url","地铁时刻表":"url"],
                   "easterEgg":["vlog1":"vlog1","vlog2回家游记":"vlog2","vlog3回家游记":"vlog3"],
                   ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! SubRoomController).name=segue.identifier!
        (segue.destination as! SubRoomController).dataForSubRoom=self.allData[segue.identifier!] ?? ["这个房间还没有什么备注哦~":"url"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func contentsOfNotifications(time:DateComponents, title:String, body:String) {
        let content = UNMutableNotificationContent()
        //设置推送内容
        content.title = title
        content.body = body
        //设置触发器
        let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
        //设置请求标志符
        let requestId = "\(String(describing: time.day)):\(String(describing: time.hour)):\(String(describing: time.minute))"
        //设置请求通知
        let request = UNNotificationRequest(identifier: requestId, content: content, trigger: trigger)
        //将通知发送至请求中心
        UNUserNotificationCenter.current().add(request)
    }
    
    private func setUpNotifications() {
        for day in 1...7 {
            if day == 7 || day == 1 || day == 4 {
                var time = DateComponents()
                time.weekday = day
                //8:10的出门信息
                time.hour = 8
                time.minute=10
                self.contentsOfNotifications(time: time, title: "宝贝出门啦！", body: "小风扇，家门钥匙，手机，充电宝，数据线和教材带齐了吗？")
                //8:50到琴行的消息
                time.hour = 8
                time.minute = 50
                self.contentsOfNotifications(time: time, title: "马上要上班咯~", body: "别忘记打卡哦！")
                //17:50马上下班的消息
                time.hour = 17
                time.minute = 50
                self.contentsOfNotifications(time: time, title: "辛苦了~快下班啦", body: "学生的家长消息回了吗？学生们签课了吗？魏老师签课了吗？10分钟后下班打卡！")
            }else {
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                var time = DateComponents()
                time.weekday = day
                //12:10的出门信息
                time.hour = 12
                time.minute=10
                self.contentsOfNotifications(time: time, title: "宝贝出门啦！", body: "家门钥匙，手机，充电宝，数据线和教材带齐了吗？")
                //12:50到琴行的消息
                time.hour = 12
                time.minute = 50
                self.contentsOfNotifications(time: time, title: "马上要上班咯~", body: "别忘记打卡哦！")
                //20:50马上下班的消息
                time.hour = 20
                time.minute = 50
                self.contentsOfNotifications(time: time, title: "辛苦了~快下班啦", body: "学生的家长消息回了吗？学生们签课了吗？魏老师签课了吗？10分钟后下班打卡! 回家注意安全，想我了随时在滴！")
            }
        }
        
    }
    
    
}




