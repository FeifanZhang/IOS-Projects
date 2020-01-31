//
//  ViewController.swift
//  Sw-SwishGesture
//
//  Created by Steven Senger on 11/19/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

  @IBOutlet var typeLabel: UILabel!

  @objc
  func leftSwish(_ gesture: SwishGestureRecognizer) {
    self.typeLabel.text = "left swish"
    (self.view as! SwishGestureView).gesture = gesture
    self.view.setNeedsDisplay()
  }

    @objc
    func rightSwish(_ gesture: SwishGestureRecognizer) {
        self.typeLabel.text = "right swish"
        (self.view as! SwishGestureView).gesture = gesture
        self.view.setNeedsDisplay()
    }

    @objc
    func upSwish(_ gesture: SwishGestureRecognizer) {
        self.typeLabel.text = "up swish"
        (self.view as! SwishGestureView).gesture = gesture
        self.view.setNeedsDisplay()
    }

    @objc
    func downSwish(_ gesture: SwishGestureRecognizer) {
        self.typeLabel.text = "down swish"
        (self.view as! SwishGestureView).gesture = gesture
        self.view.setNeedsDisplay()
    }

  @objc
  func upRightSwish(_ gesture: SwishGestureRecognizer) {
    self.typeLabel.text = "up || right swish"
    (self.view as! SwishGestureView).gesture = gesture
    self.view.setNeedsDisplay()
  }

    @objc
    func downRightSwish(_ gesture: SwishGestureRecognizer) {
        self.typeLabel.text = "down || right swish"
        (self.view as! SwishGestureView).gesture = gesture
        self.view.setNeedsDisplay()
    }

    @objc
    func downLeftSwish(_ gesture: SwishGestureRecognizer) {
        self.typeLabel.text = "down || left swish"
        (self.view as! SwishGestureView).gesture = gesture
        self.view.setNeedsDisplay()
    }

    @objc
    func upLeftSwish(_ gesture: SwishGestureRecognizer) {
        self.typeLabel.text = "up || left swish"
        (self.view as! SwishGestureView).gesture = gesture
        self.view.setNeedsDisplay()
    }
    
    @objc
    func exceptionSwish(_ gesture: SwishGestureRecognizer) {
        self.typeLabel.text = "exception swish"
        (self.view as! SwishGestureView).gesture = nil
        self.view.setNeedsDisplay()
    }

  override func viewDidLoad() {
    super.viewDidLoad()

    let leftSwish = SwishGestureRecognizer()
    leftSwish.requiredDirections = [SwishGestureRecognizer.SwishDirections.SwishLeft]
    leftSwish.delegate = self
    leftSwish.addTarget(self, action: #selector(leftSwish(_:)))
    self.view.addGestureRecognizer(leftSwish)

    let rightSwish = SwishGestureRecognizer()
    rightSwish.requiredDirections = [SwishGestureRecognizer.SwishDirections.SwishRight]
    rightSwish.delegate = self
    rightSwish.addTarget(self, action: #selector(rightSwish(_:)))
    self.view.addGestureRecognizer(rightSwish)

    let upSwish = SwishGestureRecognizer()
    upSwish.requiredDirections = [SwishGestureRecognizer.SwishDirections.SwishUp]
    upSwish.delegate = self
    upSwish.addTarget(self, action: #selector(upSwish(_:)))
    self.view.addGestureRecognizer(upSwish)

    let downSwish = SwishGestureRecognizer()
    downSwish.requiredDirections = [SwishGestureRecognizer.SwishDirections.SwishDown]
    downSwish.delegate = self
    downSwish.addTarget(self, action: #selector(downSwish(_:)))
    self.view.addGestureRecognizer(downSwish)

    let upRightSwish = SwishGestureRecognizer()
    upRightSwish.requiredDirections = [SwishGestureRecognizer.SwishDirections.SwishUp, SwishGestureRecognizer.SwishDirections.SwishRight]
    upRightSwish.delegate = self
    upRightSwish.addTarget(self, action: #selector(upRightSwish(_:)))
    self.view.addGestureRecognizer(upRightSwish)

    let downRightSwish = SwishGestureRecognizer()
    downRightSwish.requiredDirections = [SwishGestureRecognizer.SwishDirections.SwishDown, SwishGestureRecognizer.SwishDirections.SwishRight]
    downRightSwish.delegate = self
    downRightSwish.addTarget(self, action: #selector(downRightSwish(_:)))
    self.view.addGestureRecognizer(downRightSwish)

    let upLeftSwish = SwishGestureRecognizer()
    upLeftSwish.requiredDirections = [SwishGestureRecognizer.SwishDirections.SwishLeft, SwishGestureRecognizer.SwishDirections.SwishUp]
    upLeftSwish.delegate = self
    upLeftSwish.addTarget(self, action: #selector(upLeftSwish(_:)))
    self.view.addGestureRecognizer(upLeftSwish)

    let downLeftSwish = SwishGestureRecognizer()
    downLeftSwish.requiredDirections = [SwishGestureRecognizer.SwishDirections.SwishDown, SwishGestureRecognizer.SwishDirections.SwishLeft]
    downLeftSwish.delegate = self
    downLeftSwish.addTarget(self, action: #selector(downLeftSwish(_:)))
    self.view.addGestureRecognizer(downLeftSwish)
    
    let exceptionSwish = SwishGestureRecognizer()
    exceptionSwish.delegate = self
    exceptionSwish.addTarget(self, action: #selector(exceptionSwish(_:)))
    self.view.addGestureRecognizer(exceptionSwish)
    
 }



}
