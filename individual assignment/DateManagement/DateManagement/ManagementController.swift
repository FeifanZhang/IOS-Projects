//
//  ManagementController.swift
//  DateManagement
//
//  Created by 张非凡 on 11/25/18.
//  Copyright © 2018 张非凡. All rights reserved.
//

import UIKit
import Foundation

class ManagementController: UITableViewController {
    var eventKey:String!
    var eventData=[[String:String]]()
    var selectedIndexPaths=[IndexPath]()
    var storeSeletedIndexPaths=[IndexPath]()
    var viewController:ViewController?
    
    func updateEventData(singleEvent:[String:String],updateIndexPath:IndexPath){
        eventData[updateIndexPath.row]=singleEvent
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var actionList=[UITableViewRowAction]()
        if indexPath.row<eventData.count{
            if Bool(self.eventData[indexPath.row]["setUpAlarm"]!)!{
                let cancel=UITableViewRowAction.init(style: .normal, title: "Cancel"){action,index in
                    self.eventData[indexPath.row]["setUpAlarm"]="false"
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                cancel.backgroundColor=UIColor.red
                actionList.append(cancel)
            }else{
                let finish=UITableViewRowAction.init(style: .normal, title: "Finish"){action,index in
                    self.eventData[indexPath.row]["setUpAlarm"]="true"
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                finish.backgroundColor=UIColor.green
                actionList.append(finish)
            }
            let delete=UITableViewRowAction.init(style: .normal, title: "Delete"){action,index in
                self.eventData.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            delete.backgroundColor=UIColor.red
            actionList.append(delete)
            return actionList
            
        }else{
            return nil
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.eventData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            self.eventData.append(["from":"00:00","to":"00:00","detail":"detail","eventName":"event name","setUpAlarm":"false"])
            tableView.insertRows(at: [IndexPath(row: self.eventData.count-1, section: 0)], with: .automatic)
        case .none:
            break
        }
    }
    
    //tableView进入editing模式时，增加一个add cell, 退出editing模式时,把add cell减掉
    //本协议作用是判断tableView是否进入editing模式
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        let lastCellPath = IndexPath(row: self.eventData.count, section: 0)
        if editing {
            storeSeletedIndexPaths=selectedIndexPaths
            //如果将array进行等于nil操作，则不仅将array数据清空，还会将其memory释放，所以清空数组的最好方法为.removeAll()
            selectedIndexPaths.removeAll()
            self.tableView.insertRows(at: [lastCellPath], with: .right)
        }else {
            selectedIndexPaths=storeSeletedIndexPaths
            storeSeletedIndexPaths.removeAll()
            self.tableView.deleteRows(at: [lastCellPath], with: .right)
        }
    }
    
    //在tableView进入editing时,eventData中的事情为可删除,剩下的一个(为add cell)是可以添加的。
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if !self.tableView.isEditing {
            return .none
        }else if (indexPath.row < self.eventData.count){
            return .delete
        }else{
            return .insert
        }
    }
    
    //如果cell是被选中的，则height为90，没被选中则为40
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight=CGFloat()
        //cell是被选中的
        if selectedIndexPaths.contains(indexPath){
            cellHeight=200
        }else{
            cellHeight=40
        };return cellHeight
    }
    
    //如果被点击的cell在selectedIndexPaths中，则将其删掉(即使其变为不被选状态)，反之加入selecetedIndexPaths中。
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.tableView.isEditing{
            if indexPath.row<=eventData.count-1{
                //第一个name为Storyboard的名字(Main.storyboard,名字为Main)
                //withIdentifier是storyboard下面的每一个界面的controllers的stordboardID
                let eventEdit=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "eventEdit") as! EventEditController
                eventEdit.title=eventData[indexPath.row]["eventName"]
                eventEdit.singleEvent=eventData[indexPath.row]
                eventEdit.updateIndexPath=indexPath
                eventEdit.management=self
                self.navigationController!.pushViewController(eventEdit, animated: true)
            }
        }else{
            if let index=selectedIndexPaths.firstIndex(of: indexPath){
                selectedIndexPaths.remove(at: index)
            }else{
                selectedIndexPaths.append(indexPath)
            };tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    //如果是编辑模式的话，行数+1，提供add方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.isEditing) ? self.eventData.count+1 : self.eventData.count
    }
    
    //如果cell是selected的，则将detail添加至cell中
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //在main storyboard中设置cell的indentifier不然无法启用
        //在main storyboard中设置了identifier之后，就不用在viewDidLoad中注册了
        let cell:ManagementControllerCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! ManagementControllerCell
        if indexPath.row < self.eventData.count {
            //如果cell是被选中的，则将detail添加至cell中
            if selectedIndexPaths.contains(indexPath){
                cell.detail?.text=self.eventData[indexPath.row]["detail"]
            }
            cell.textLabel!.text = self.eventData[indexPath.row]["from"]!+"~"+self.eventData[indexPath.row]["to"]!
            cell.setUpAlarm=Bool(eventData[indexPath.row]["setUpAlarm"]!)!
            cell.eventName?.text=eventData[indexPath.row]["eventName"]
            cell.detail?.text=eventData[indexPath.row]["detail"]
        }else{
            cell.textLabel!.text = "new cell"
            cell.detailTextLabel!.text = ""
            cell.eventName?.text=""
            cell.detail?.text=""
        };return cell
    }
    override func viewWillDisappear(_ animated: Bool) {
        viewController!.manageDate[eventKey!]=eventData
    }

    override func viewWillAppear(_ animated: Bool) {
        eventData.sort(by: sortDate)
    }
    
    func sortDate(element1:[String:String],element2:[String:String]) -> Bool{
        //字符串不能用 ">"和 “<“ 去比较
        print(element1["from"]?.caseInsensitiveCompare(element2["from"]!)==ComparisonResult.orderedAscending)
        return element1["from"]?.caseInsensitiveCompare(element2["from"]!)==ComparisonResult.orderedAscending
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
}
