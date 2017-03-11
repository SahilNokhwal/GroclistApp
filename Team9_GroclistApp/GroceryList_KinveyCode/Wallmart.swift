//
//  WallmartVO.swift
//  Team09
//
//  Created by Nokhwal,Sahil on 4/13/16.
//  Copyright © 2016 Sahil Nokhwal. All rights reserved.
//

import Foundation


class Wallmart{
    
    
    var   name:String = ""
    var  salePrice:Double = 0.0
    var thumbnailImage:String = ""
    
    init(name:String,salePrice:Double,thumbnailImage:String)
    {
        self.name = name
        self.salePrice = salePrice
        self.thumbnailImage = thumbnailImage
    }
    
    
}