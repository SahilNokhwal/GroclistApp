//
//  Product.swift
//  Team09_Groclist
//
//  Created by Abishai Parise on 3/18/16.
//  Copyright © 2016 Parise,Prem Abishai. All rights reserved.
//

import Foundation
import UIKit

class Product {
    
    var itemId:Int
    var itemName:String
    var salePrice:Double
    var imageUrl:String!
    
    init(itemId:Int,itemName:String,salePrice:Double,imageUrl:String){
        
        self.itemId = itemId
        self.itemName = itemName
        self.salePrice = salePrice
        self.imageUrl = imageUrl
        //print(self.itemName)
    }
    
}