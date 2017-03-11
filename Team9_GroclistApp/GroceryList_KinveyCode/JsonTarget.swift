//
//  JsonTarget.swift
//  GroceryList_KinveyCode
//
//  Created by Akkiraju,Prahasith on 3/16/16.
//  Copyright © 2016 Akkiraju,Prahasith. All rights reserved.
//

import Foundation
import UIKit


class JsonTarget {
    //for the use of the json retreiving
    
    var cat_name : Categories = Categories()
    var sh : [Shoper] = []
    
    //------
    //var stri : String = "Target"
    var samp : String = "http://baas.kinvey.com/appdata/kid_W1Sl3at5yW/"
    var name : String!
    var user:String?
    var apiKey = "kid_W1Sl3at5yW"
    var session:NSURLSession!
    
    func shopper() {
        
        var url = samp + name
        let defaultConfigObject:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: defaultConfigObject, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        
        if (self.user == nil) {
            createUser(shopper)
        } else {
        
      print(url)
        
        var mutableUrl = NSMutableURLRequest(URL:  NSURL(string: url)!)
        mutableUrl.HTTPMethod = "GET"
        
        
        
        mutableUrl.setValue(user, forHTTPHeaderField: "Authorization")
        
        let task = session.dataTaskWithRequest(mutableUrl) { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                do {
                   
                if let responseBody : [AnyObject] = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? [AnyObject]  {
                    //print(responseBody)
                    if (error == nil) {
                        //as! NSDictionary
                        
                        for data_cat in responseBody {
                            
                            let categories = data_cat["categories"]!! as! String
                            if(self.cat_name.categoryname.contains(categories)){
                                
                            }
                            else {
                                
                                self.cat_name.categoryname.append(categories)
                            }
                            
                           // print(self.cat_name.categoryname)
                        }
                        
                        
                        for shp in responseBody {
                            
                            let categories = shp["categories"]!! as! String
                            let id = self.cat_name.categoryname.indexOf(categories)!
                            //object of shopper created created.
                            let price = shp["price"]!! as! String
                            let product = shp["product"]!! as! String
                            let quantity = shp["quantity"] as! String
                            let shoper = Shoper(id: id,product: product, quantity: quantity, price: price)
                            self.sh.append(shoper)
                            
                        }
                        
                       
                        
                        
                        print(self.cat_name.categoryname)
                        
                        
                       
                    }
                }
                NSNotificationCenter.defaultCenter().postNotificationName("Data Send", object: nil)
                }catch{
                    print("error1")
                }}
        }
        task.resume()
            
        }
    }
    
    
    
    func createUser(completion:()->()) {
        let request = NSMutableURLRequest()
        let urlStr = "https://baas.kinvey.com/user/kid_W1Sl3at5yW"
        request.URL = NSURL(string: urlStr)
        request.HTTPMethod = "POST"
        
        let body : Dictionary = Dictionary<String,String>()
        var e : NSError?
        let opt : NSJSONWritingOptions? = nil
        var bodyData:NSData = NSData()
        do{
            bodyData = try NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions.PrettyPrinted)
            
        }catch{
            print("user error")
        }
        
        
        request.HTTPBody = bodyData;
        
        let cred = "kid_W1Sl3at5yW:351b8b554303461d810147550981dd6e".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let credData = cred!.base64EncodedStringWithOptions([])
        let authValue = "Basic \(credData)"
        request.setValue(authValue, forHTTPHeaderField: "Authorization")
        
        let task = self.session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                do{
                    if let responseDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                        if let authtoken = responseDict["_kmd"]?["authtoken"] as? String {
                            print(authtoken)
                            self.user = "Kinvey \(authtoken)"
                        } else if let authtoken = responseDict["error"]?["XXXXX"] as? String {
                            // error
                             print(authtoken)
                        } else {
                            // Handle malformed server response
                             print("url error")
                        }
                    }
                    completion()}catch{
                        print("Errorr!!")
                }
            }
        }
        task.resume()
    }
}