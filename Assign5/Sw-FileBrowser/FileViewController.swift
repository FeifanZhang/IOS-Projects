//
//  FileViewController.swift
//  Sw-FileBrowser
//
//  Created by Steven Senger on 10/11/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class FileViewController: UITableViewController {
  
  let sectionNames = ["Creation Date", "Modification Date", "Size","Permission"]
  var permissions = [String]()
  var detailPath = ""
  var attributes = [FileAttributeKey:Any]()
  var root:RootViewController?
  
  // Mark: UITableViewDataSource Protocol Methods
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // return number of sections
    return 4;
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // some sections have a single row, contents sections for directories have several rows
    var row=1
    switch section {
    case 3:
        if(self.permissions.count != 0){
           row=self.permissions.count
        }else{
           row=1
        }
    default:
        row=1
    }
    return row;
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // get a cell either reuseable from table or newly created
    // use switch on section
    // textLabel text comes from attributes
    // return the cell
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
    if cell == nil {
        cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }
    switch indexPath.section {
    case 0:
        let creationDate=String(describing: self.attributes[FileAttributeKey.creationDate])
        let startIndex = creationDate.index(creationDate.startIndex, offsetBy: 9)
        let endIndex = creationDate.index(of:")")
        cell?.textLabel!.text=String(creationDate[startIndex..<endIndex!])
    case 1:
        let modificationDate=String(describing: self.attributes[FileAttributeKey.modificationDate])
        let startIndex = modificationDate.index(modificationDate.startIndex, offsetBy: 9)
        let endIndex = modificationDate.index(of:")")
        cell?.textLabel!.text=String(modificationDate[startIndex..<endIndex!])
    case 2:
        let size=String(describing: self.attributes[FileAttributeKey.size])
        let startIndex = size.index(size.startIndex, offsetBy: 9)
        let endIndex = size.index(of:")")
        cell?.textLabel!.text=String(size[startIndex..<endIndex!])
    case 3:
        if(self.permissions.count != 0){
            cell?.textLabel!.text=self.permissions[indexPath.row]
        }else{
            cell?.textLabel!.text="No permossions avaliable"
        }
        
    default:
        return cell!
        
    };return cell!
  }
  
  // Mark: UITableViewDelegate Methods
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    // return the section name
    return self.sectionNames[section]
  }
  
  override func viewDidLoad() {
    // set self.title from detailPath last component
    // get attributes of detailPath
    super.viewDidLoad()
    let file = FileManager.default
    var titleList  = self.detailPath.components(separatedBy:"/")
    self.title = titleList[titleList.endIndex-1]
    do{
       self.attributes=try file.attributesOfItem(atPath: detailPath)
    }catch{
       self.attributes[FileAttributeKey.creationDate]="No creation date available"
       self.attributes[FileAttributeKey.modificationDate]="No modification date available"
       self.attributes[FileAttributeKey.size]="No size available"
    }
    
    if(file.isDeletableFile(atPath: self.detailPath)){
        self.permissions.append("DeletableFile")
    }
    if(file.isExecutableFile(atPath: self.detailPath)){
        self.permissions.append("ExecutableFile")
    }
    if(file.isReadableFile(atPath: self.detailPath)){
        self.permissions.append("ReadableFile")
    }
    if(file.isWritableFile(atPath: self.detailPath)){
        self.permissions.append("WritableFile")
    }
    self.permissions=self.sortCaseInsensitive(strArray: self.permissions)
  }
    
    
    func sortCaseInsensitive(strArray:[String])->[String]{
        var strings=strArray
        for(index,value) in strings.enumerated(){
            var counter = index;
            if(index==strings.count-1){
                break
            }
            for i in index+1...strings.count-1{
                if(strings[counter].caseInsensitiveCompare(strings[i])==ComparisonResult.orderedDescending){
                    counter=i
                }
            };strings.swapAt(index, counter)
        };return strings
    }

}
