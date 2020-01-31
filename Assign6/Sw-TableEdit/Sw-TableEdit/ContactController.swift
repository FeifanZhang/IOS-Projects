//
//  ContactController.swift
//  Sw-TableEdit
//
//  Created by Steven Senger on 9/24/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class ContactController: UIViewController, UITextFieldDelegate {
  
  var detailDictionary = [String:String]()
  var detailIndexPath = IndexPath()
  var master: ContactListController?
  
  @IBOutlet var nameField: UITextField!
  @IBOutlet var phoneField: UITextField!
  @IBOutlet var nameRevertButton: UIButton!
  @IBOutlet var phoneRevertButton: UIButton!
  @IBOutlet var deletionLockSwich:UISwitch!
  @IBOutlet var movementLockSwich:UISwitch!
  
  @IBAction func nameFieldChanged(sender: UITextField) {
    self.nameRevertButton.isHidden = false;
  }
  
  @IBAction func phoneFieldChanged(sender: UITextField) {
    self.phoneRevertButton.isHidden = false;
  }
  
  @IBAction func revertNameField(sender: UIButton) {
    self.nameField.text = self.detailDictionary["Name"]
    self.nameRevertButton.isHidden = true
  }
  
  @IBAction func revertPhoneField(sender: UIButton) {
    self.phoneField.text = self.detailDictionary["Phone"]
    self.phoneRevertButton.isHidden = true
  }
  
  // Mark: UITextFieldDelegate Protocol Methods
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return textField.text != ""
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  // Mark: UIViewController Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.nameRevertButton.isHidden = true
    self.phoneRevertButton.isHidden = true
    self.nameField.text = self.detailDictionary["Name"]
    self.phoneField.text = self.detailDictionary["Phone"]
    self.deletionLockSwich.isOn=Bool(self.detailDictionary["deletionLock"]!)!
    self.movementLockSwich.isOn=Bool(self.detailDictionary["movementLock"]!)!
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    var hasChanged = false
    
    if self.detailDictionary["Name"] != self.nameField.text {
      self.detailDictionary["Name"] = self.nameField.text
      hasChanged = true
    }
    
    if self.detailDictionary["Phone"] != self.phoneField.text {
      self.detailDictionary["Phone"] = self.phoneField.text
      hasChanged = true
    }
    
    if self.detailDictionary["deletionLock"] != String(self.deletionLockSwich.isOn) {
        self.detailDictionary["deletionLock"] = String(self.deletionLockSwich.isOn)
        hasChanged = true
    }
    
    if self.detailDictionary["movementLock"] != String(self.movementLockSwich.isOn) {
        self.detailDictionary["movementLock"] = String(self.movementLockSwich.isOn)
        hasChanged = true
    }
    
    if hasChanged {
      // this detail controller has already been removed from hierarchy (presentingViewController is nil
      // so navigationController topViewController is our table view controller
      self.master!.updateContact(self.detailDictionary, at: self.detailIndexPath)
      self.master!.tableView.reloadRows(at: [self.detailIndexPath], with: .automatic)
    }
  }
}
