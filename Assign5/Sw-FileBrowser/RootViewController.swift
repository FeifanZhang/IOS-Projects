//
//  RootViewController.swift
//  Sw-FileBrowser
//
//  Created by Steven Senger on 10/11/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

  let sectionNames = ["Creation Date", "Modification Date", "SubDirectory","File"]
  
  var detailPath = "/"
  var subDirs = [String]()
  var files=[String]()
  var attributes = [FileAttributeKey:Any]()
  var root:RootViewController?
    
  
  // Mark: UITableViewDataSource Protocol Methods
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // return number of sections
    return 4;
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // use a switch on the section number
    // sections 0 and 1 have 1 row, sections 2 has a row for each sub directory
    var row=0;
    switch section {
    case 0:
        row = 1;
    case 1:
        row = 1;
    case 2:
        if(self.subDirs.count==0){
            row=1
        }else{
           row = subDirs.count;
        }
    case 3:
        if(self.files.count==0){
            row=1
        }else{
            row = files.count;
        }
    default:
        row = 0;
    };return row
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // use a switch on the section number
    // set the cell.accessoryType and cell.textLabel.text
    // accessoryType is either UITableViewCell.AccessoryType.none or UITableViewCell.AccessoryType.disclosureIndicator
    // text either comes from attributes or sub directories
    var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
      
    }
    switch indexPath.section{
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
        if(self.subDirs.count==0){
            cell?.textLabel!.text="No SubDirectory avaliable"
        }else{
            //此语句为设置右侧箭头
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel!.text=self.subDirs[indexPath.row]
        }
    case 3:
        if(self.files.count==0){
            cell?.textLabel!.text="No File avaliable"
        }else{
            //此语句为设置右侧箭头
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel!.text=self.files[indexPath.row];
        }
    default:
        return cell!;
    };return cell!;
    
    //dev/stderr/,
  }
  
  // Mark: UITableViewDelegate Methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // if section is not 2 there is nothing to do
    // if selected row is a subdirectory entry then create new RootViewController
    // if selected row is a file entry then create new FileViewcontroller
    // in both cases set detailPath on controller and tell navigationController to push it
    switch indexPath.section {
    case 2:
        if(self.subDirs.count != 0){
            let ctlr=RootViewController(style: .plain)
            ctlr.detailPath = self.detailPath+subDirs[indexPath.row]+"/"
            ctlr.root=self
            self.navigationController!.pushViewController(ctlr, animated: true)
        }
    case 3:
        if(self.files.count != 0){
            let ctlr=FileViewController(style: .plain)
            ctlr.detailPath = self.detailPath+self.files[indexPath.row]
            ctlr.root=self
            print("file")
            self.navigationController!.pushViewController(ctlr, animated: true)
        }
    default:
        return;
    };return;

  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    return self.sectionNames[section]
  }
    
    
  
  override func viewDidLoad() {
    // set self.title from detailPath last component
    // make an array of subdirectories of detailPath, exclude things that start with "."
    // get attributes of detailPath
    super.viewDidLoad()
    let file = FileManager.default
    var dirAndFile = try! file.contentsOfDirectory(atPath: self.detailPath)
    dirAndFile=dirAndFile.filter{elt in !elt.hasPrefix(".")}
    var isDirs = ObjCBool.init(false)
    for value in dirAndFile{
        if(file.fileExists(atPath: self.detailPath+value,isDirectory: &isDirs) && isDirs.boolValue){
            self.subDirs.append(value)
        }else{
            self.files.append(value)
        }
    }
    
    self.files=self.sortCaseInsensitive(strArray: self.files)
    self.subDirs=self.sortCaseInsensitive(strArray: self.subDirs)
    var titleList = self.detailPath.components(separatedBy:"/")
    if(titleList[titleList.endIndex-1]=="" || titleList.count==0){
        titleList.remove(at: titleList.endIndex-1)
    }
    if(titleList[titleList.endIndex-1]==""){
       self.title = self.detailPath
    }else{
       self.title=titleList[titleList.endIndex-1]
    }
    do{
       self.attributes=try file.attributesOfItem(atPath: detailPath)
    }catch{
        self.attributes[FileAttributeKey.creationDate]="No creation date available for it"
        self.attributes[FileAttributeKey.modificationDate]="No modification date available for it"
    }
    

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
