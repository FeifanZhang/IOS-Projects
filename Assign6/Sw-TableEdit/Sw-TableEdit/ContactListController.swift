//
//  ViewController.swift
//  Sw-TableEdit
//
//  Created by Steven Senger on 9/24/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//
import Foundation
import UIKit

class ContactListController: UITableViewController {

  var contactList = [[String:String]]()
  
  // Mark: UITableViewDataSource Protocol Editing Methods
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
    case .delete:
            self.contactList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
    case .insert:
        self.contactList.append(["Name":"Some One", "Phone":"(0)-0","deletionLock":"false","movementLock":"false"])
      tableView.insertRows(at: [IndexPath(row: self.contactList.count-1, section: 0)], with: .automatic)
    case .none:
      break
    }
  }
  
  // Mark: UITableViewDataSource Protocol Row Movement Methods
  
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    if indexPath.row > self.contactList.count-1{
        return indexPath.row < self.contactList.count
    }else{
        return !Bool(self.contactList[indexPath.row]["movementLock"]!)!
    }
    
  }
  
  override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
    if(proposedDestinationIndexPath.row < self.contactList.count){
        if(sourceIndexPath.row < proposedDestinationIndexPath.row){//上往下拿
            for index in sourceIndexPath.row...proposedDestinationIndexPath.row {
                if(Bool(self.contactList[index]["movementLock"]!)!){return sourceIndexPath}
        };return proposedDestinationIndexPath
        }else{//从下往上拿
            for index in proposedDestinationIndexPath.row...sourceIndexPath.row{
                if(Bool(self.contactList[index]["movementLock"]!)!){return sourceIndexPath}
            };return proposedDestinationIndexPath
        }
    }else{return sourceIndexPath}
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    self.contactList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
  }
  
  // Mark: UIViewController Editing Methods
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    let lastCellPath = IndexPath(row: self.contactList.count, section: 0)
    if editing {
      self.tableView.insertRows(at: [lastCellPath], with: .right)
    }
    else {
      self.tableView.deleteRows(at: [lastCellPath], with: .right)
    }
  }
  
  // Mark: UITableViewDatasource Protocol Methods
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (self.isEditing) ? self.contactList.count+1 : self.contactList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //在main storyboard中设置cell的indentifier不然无法启用
    let cell:CustomizeCell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as! CustomizeCell
    
    if indexPath.row < self.contactList.count {
      cell.textLabel!.text = self.contactList[indexPath.row]["Name"]
      cell.detailTextLabel!.text=self.contactList[indexPath.row]["Phone"]
      cell.setDeletionLock(deletionLock: Bool(self.contactList[indexPath.row]["deletionLock"]!)!)
      cell.setMovementLock(movementLock: Bool(self.contactList[indexPath.row]["movementLock"]!)!)
    }else {
      cell.textLabel!.text = "new cell"
      cell.detailTextLabel!.text = ""
      cell.setDeletionLock(deletionLock: false)
      cell.setMovementLock(movementLock: false)
     
        
    }
    print(cell.deletionStatement?.textColor)
    print(cell.movementStatement?.textColor)
    return cell
  }
  
  // Mark: UITableViewDelegate Protocol Methods
  //在contactList中且返回为.none的row，可以更改位置，但不可以删除。
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    if !self.tableView.isEditing {
      return .none
    }
    else if (indexPath.row < self.contactList.count){
        return(!Bool(self.contactList[indexPath.row]["deletionLock"]!)!) ? .delete: .none
    }else{
        return .insert
    }
  }

  // Mark: UIViewController Methods
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showContact" {
      let detailIndexPath = self.tableView.indexPathForSelectedRow
      (segue.destination as! ContactController).detailDictionary = self.contactList[detailIndexPath!.row]
      (segue.destination as! ContactController).detailIndexPath = detailIndexPath!
      (segue.destination as! ContactController).master = self;
    }
  }
  
  func updateContact(_ contact: [String:String], at indexPath: IndexPath) {
    self.contactList[indexPath.row] = contact
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //tableView.register(CustomizeCell.self, forCellReuseIdentifier: "cell")
    self.contactList = [ ["Name": "Mr Boulder", "Phone":"(1)-1","deletionLock":"false","movementLock":"false"],
                         ["Name": "Fred Flintstone", "Phone":"(1)-3","deletionLock":"false","movementLock":"false"],
                         ["Name": "Wilma Flintstone", "Phone":"(1)-3","deletionLock":"false","movementLock":"false"],
                         ["Name": "Barney Rubble", "Phone":"(1)-4","deletionLock":"false","movementLock":"false"],
                         ["Name": "Bam Bam Rubble", "Phone":"(1)-5","deletionLock":"false","movementLock":"false"]
                       ]
    self.navigationItem.rightBarButtonItem = self.editButtonItem
  }


}

