//
//  ManagementController.swift
//  DateManagement
//
//  Created by 张非凡 on 11/25/18.
//  Copyright © 2018 张非凡. All rights reserved.
//

import UIKit
import Foundation

class SubRoomController: UITableViewController {
    var nameOfTitle=["livingRoom":"客厅",
                     "canteen":"餐厅",
                     "restRoom":"厕所",
                     "smallBedRoom":"小卧室",
                     "bigBedRoom":"大卧室",
                     "darkRoom":"小黑屋",
                     "balcony":"阳台",
                     "kitchen":"厨房",
                     "outside":"出门",
                     "easterEgg":"彩蛋！！！"
                     ]
    var name=String()
    var dataForSubRoom=[String:String]()
    var names=[String]()
    var selectedPath=IndexPath()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.title=nameOfTitle[name]
        self.names=[String](self.dataForSubRoom.keys)
        //清除cell的分割线
        let footerView = UIView(frame: .zero)
        tableView.tableFooterView = footerView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return number of sections
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForSubRoom.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SubRoomControllerCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! SubRoomControllerCell
        cell.title?.text=self.names[indexPath.row]
        cell.url=self.dataForSubRoom[self.names[indexPath.row]]
        if self.selectedPath.isEmpty {
            cell.play?.pause()
        }else if self.selectedPath==indexPath {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.7){
                cell.play!.play()
            }
        }else{
            cell.play!.pause()
        };return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell是第一个被选中的
        if self.selectedPath.isEmpty {
            self.selectedPath=indexPath
        }else if self.selectedPath.row==indexPath.row{
            self.selectedPath=IndexPath()
        }else {
            self.selectedPath=indexPath
        };tableView.reloadData()
    }
    
    //如果cell是被选中的，则height为250，没被选中则为40
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight=CGFloat()
        //cell是被选中的
        if self.selectedPath.isEmpty || self.selectedPath.row != indexPath.row {
            cellHeight=40
        }else{
            cellHeight=280
        };return cellHeight
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view=nil
    }
}
