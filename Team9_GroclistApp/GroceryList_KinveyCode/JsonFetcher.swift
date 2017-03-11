//
//  JsonFetcher.swift
//  Parise_Groclist
//
//  Created by Abishai Parise on 3/13/16.
//  Copyright © 2016 Abishai Parise. All rights reserved.
//

import UIKit
class JSONFetcher  {
    
    // JSONFetcher is a model
    
    var categoryName:[WalmartModel]! = []
    var prod:[Product] = []
    //http://api.walmartlabs.com/v1/taxonomy?format=json&apiKey=jqaxentbfgqw9wd8h5f53x2u
    /* Goes out to the designated url, downloads the */
    init(){
        self.categoryName = []
        
    }
    func fetchJSON(url:String){
        print(url)
//        let session:NSURLSession = NSURLSession.sharedSession()
//        session.dataTaskWithURL( NSURL(string: url)!, completionHandler: processResults).resume()
        
        do{
            let url: NSURL! = NSURL(string: url)
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            let error: NSError?
            
            var response: NSURLResponse?
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            
            // print(data)
            
            processResults(data)
            
        }
        catch{
            print("Error in Network")
        }

        
    }
    func fetchProductJSON(url:String){
        print(url)
        let session:NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithURL( NSURL(string: url)!, completionHandler: processProductResults).resume()
        
    }
    
    
    
    // Called when the data task completes -- we could have used a closure expression instead of a separate method ...
    func processResults(data:NSData)->Void {
        
        do {
            var count:Int = 0
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
            
            if let dict = json as? [String: AnyObject] {
                if let maincategory = dict["categories"] as? [AnyObject] {
                    
                    for dict2 in maincategory {
                        
                        let id = dict2["id"] as? String
                        
                        if  (id == "976759")  { //foo
                            
                            if let children = dict2["children"] as? [AnyObject] {
                                var cat:[Category] = []
                                var Subcat:[Subcategory] = []
                                var SubcatDic:[SubcatDictionary]!
                                for dict3 in children {
                                    
                                    
                                    let catid = dict3["id"] as! String
                                    let catname = dict3["name"] as! String
                                    
                                    let categoryName = Category(name: catname,id: catid)
                                    cat.append(categoryName)
                                    if let children2 = dict3["children"] as? [AnyObject] {
                                        SubcatDic = []
                                        for dict4 in children2 {
                                            
                                            let subcatid = dict4["id"] as! String
                                            let subcatname = dict4["name"] as! String
                                            // print(subcatname)
                                            SubcatDic.append(SubcatDictionary(catId: subcatid, name: subcatname))
                                            count++
                                            
                                            
                                        }
                                        //                                        print(" sub cat Count")
                                        //                                        print(count)
                                        let subcatName = Subcategory(catId: catid, namesMap: SubcatDic)
                                        Subcat.append(subcatName)
                                        
                                        
                                        
                                    }
                                    // print("hello")
                                    // print(catname)
                                }
                                let walmartinfo = WalmartModel(category: cat,subcategory: Subcat)
                                self.categoryName.append(walmartinfo)
                                
                            }
                        }
                        
                    }
                }
            }
            
        }
        catch {
            let blamees:[String] = ["Dennis", "Michael", "Charles"]
            print("Something has gone wrong -- I think we'll blame it on \(blamees[random()%blamees.count])")
        }
        
        
        
    }
    
    
    //fetches product data
    func processProductResults(data:NSData?,response:NSURLResponse?,error:NSError?)->Void {
        
        do {
            var count:Int = 0
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            prod = []
            if let dict = json as? [String: AnyObject] {
                if let products = dict["items"] as? [AnyObject] {
                    
                    for product in products {
                        count++
                        
                        if let price = product["salePrice"] as? Double {
                            let id = product["itemId"] as! Int
                            //let price = product["salePrice"] as! Double
                            let itemName = product["name"] as! String
                            let imgUrl = product["thumbnailImage"] as! String
                            
                            // print(itemName)
                            prod.append(Product(itemId: id, itemName: itemName, salePrice: price, imageUrl: imgUrl))
                            
                        }
                        
                    }
                    
                }
            }
            
            // print(count)
        }
        catch {
            let blamees:[String] = ["Dennis", "Michael", "Charles"]
            print("Something has gone wrong -- I think we'll blame it on \(blamees[random()%blamees.count])")
        }
    }
    
    
}


