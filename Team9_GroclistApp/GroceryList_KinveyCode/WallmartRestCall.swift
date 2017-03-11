//
//  WallmartRestCall.swift
//  Team09
//
//  Created by Sahil Nokhwal on 3/18/16.
//  Copyright © 2016 Sahil Nokhwal. All rights reserved.
//

import Foundation


class WallmartRestCall{
    //Rest call to wallmart
    
    var dataArray = [Wallmart]()
    
    
    func restCall(url:String){
        //print(url)
       
      //  session.dataTaskWithURL( NSURL(string: url)!, completionHandler: jsonConverter).resume()
       // send(url)
        do{
        let url: NSURL! = NSURL(string: url)
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        var error: NSError?
        
        var response: NSURLResponse?
        let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
       
       // print(data)
            
            jsonDataTemp(data)
            
        }
        catch{
            print("Error in Network")
        }
    }
    
    
    //Converting NSData to json
    
   func jsonDataTemp(data:NSData){
    do {
        
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        //  print(json)
        
        if let dict = json as? [String: AnyObject] {
            if let items = dict["items"] as? [AnyObject] {
                print("inside")
                
                for item in items {
                    
                    let dictItem = item as? [String: AnyObject]
                    
                    let nameWithComma = dictItem!["name"] as! String!
                    let salePrice = dictItem!["salePrice"] as! Double!
                    let thumbnailImage = dictItem!["thumbnailImage"] as! String!
                    var name:String = ""
                    var loop = 0
                    
                    //Trancating names
                    for char in nameWithComma.characters {
                        
                        name.append(char)
                        if char == " "{
                            loop++
                            
                            if loop > 3{
                                break
                            }
                            
                           
                        }
                        print(name)
                    }
                   
                    self.dataArray.append(Wallmart(name: name, salePrice: salePrice, thumbnailImage: thumbnailImage))
                    
                 
                    
                }
                
               
            }}
    }
    catch {
        print("Error while converting NSData to Json")
    }
    }
    
    
   }