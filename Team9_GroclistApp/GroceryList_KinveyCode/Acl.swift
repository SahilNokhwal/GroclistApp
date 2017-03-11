//
//  Acl.swift
//  GroceryList_KinveyCode
//
//  Created by Akkiraju,Prahasith on 3/17/16.
//  Copyright © 2016 Akkiraju,Prahasith. All rights reserved.
//

import Foundation
//
//	Acl.swift
//
//	Create by Student on 17/3/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Acl : NSObject, NSCoding{
    
    var creator : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        creator = dictionary["creator"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if creator != nil{
            dictionary["creator"] = creator
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        creator = aDecoder.decodeObjectForKey("creator") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if creator != nil{
            aCoder.encodeObject(creator, forKey: "creator")
        }
        
    }
    
}