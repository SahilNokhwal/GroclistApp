//
//  WalmartModel.swift
//  Team09_Groclist
//
//  Created by Parise,Prem Abishai on 3/15/16.
//  Copyright © 2016 Parise,Prem Abishai. All rights reserved.
//

import Foundation
import UIKit

class WalmartModel{
    var category:[Category]
    var subcategory:[Subcategory]
    
    init(category:[Category],subcategory:[Subcategory]){
        self.category = category
        self.subcategory = subcategory
        print(category.count)
        print(subcategory.count)
    }
    
    
    
}