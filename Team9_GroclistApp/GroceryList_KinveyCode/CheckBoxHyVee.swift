//
//  CheckBoxHyVee.swift
//  GroceryList_KinveyCode
//
//  Created by Nokhwal,Sahil on 4/17/16.
//  Copyright © 2016 Akkiraju,Prahasith. All rights reserved.
//

import UIKit

class CheckBoxHyVee: UIButton {
   
        // Images
        let checkedImage = UIImage(named: "Checked")! as UIImage
        let uncheckedImage = UIImage(named: "Unchecked")! as UIImage
        
        // Bool property
        var isChecked: Bool = false {
            didSet{
                if isChecked == true {
                    self.setImage(checkedImage, forState: .Normal)
                } else {
                    self.setImage(uncheckedImage, forState: .Normal)
                }
            }
        }
        
        override func awakeFromNib() {
            self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            self.isChecked = false
        }
        
        func buttonClicked(sender: UIButton) {
            if sender == self {
                if isChecked == true {
                    isChecked = false
                     ViewController.storeList.removeAtIndex(ViewController.storeList.indexOf((sender.titleLabel?.text)!)!)
                     print(ViewController.storeList)
                } else {
                    ViewController.storeList.append((sender.titleLabel?.text)!)
                     print(ViewController.storeList)
                    isChecked = true
                }
            }
        }
}
