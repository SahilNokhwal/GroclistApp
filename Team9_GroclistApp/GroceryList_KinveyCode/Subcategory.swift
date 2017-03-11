//
//  Subcategory.swift
//  Team09_Groclist
//
//  Created by Parise,Prem Abishai on 3/15/16.
//  Copyright © 2016 Parise,Prem Abishai. All rights reserved.
//

import Foundation
import Foundation
import UIKit


class Subcategory {
    
    var namesMap:[SubcatDictionary]
    var catId:String
    
    init(catId:String,namesMap:[SubcatDictionary]){
        self.catId = catId
        self.namesMap = namesMap
    }
    
    
}