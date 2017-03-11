//
//  ViewController.swift
//  Team09
//
//  Created by Sahil Nokhwal on 3/17/16.
//  Copyright © 2016 Sahil Nokhwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    static var storeList:[String] = []
    
    var wallmartRestCall:WallmartRestCall? = nil
    
    @IBOutlet weak var searchTF: UITextField!
    
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .Plain, target: self, action: "addLeft")
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgimg.jpg")!)
        //searchTF.delegate = self
        
    }
    
    func addLeft() {
        print("left")
        let dest =  HomeMenuViewController()
        self.navigationController?.pushViewController(dest, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if segue?.identifier == "searchProduct"{
        let searchBoxText = searchTF.text!
        let trimmedString = searchBoxText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        print(trimmedString + "----------------")
        
        // if trimmedString != ""{
        
        let apiKey = "6qzxut589kem4gfntxay7p3r"
        let url = "http://api.walmartlabs.com/v1/search?query=\(trimmedString)&format=json&apiKey=\(apiKey)"
        print(url)
        
        print(ViewController.storeList)
        
            
            if trimmedString != "" {
                
                if  ViewController.storeList.contains("Wallmart"){
                    wallmartRestCall = WallmartRestCall()
                    wallmartRestCall!.restCall(url)
                    ViewController.storeList.removeAtIndex(ViewController.storeList.indexOf("Wallmart")!)
               
                    
                    
                    
                    let destController:TableViewController = segue!.destinationViewController as! TableViewController
                    
                    print(wallmartRestCall?.dataArray)
                    destController.navTitle = trimmedString
                    // destController.navigationBarTitle.title = "Hello"
                    destController.wallmartData = wallmartRestCall?.dataArray
                    //destController.navigationBarTitle.title = trimmedString
                }
                
            }
                
            else{
                
                print("Data empty")
                
                let alertController = UIAlertController(title: "Invalid input", message:
                    "Please enter some text", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
            

        
//        wallmartRestCall = WallmartRestCall()
//        wallmartRestCall!.restCall(url)
        
        
        
//        let destController:TableViewController = segue!.destinationViewController as! TableViewController
//        
//        print(wallmartRestCall?.dataArray)
//        destController.navTitle = trimmedString
//        // destController.navigationBarTitle.title = "Hello"
//        destController.wallmartData = wallmartRestCall?.dataArray
//        //destController.navigationBarTitle.title = trimmedString
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



