//
//  Homepage.swift
//  Team09_Groclist
//
//  Created by Parise,Prem Abishai on 3/15/16.
//  Copyright © 2016 Parise,Prem Abishai. All rights reserved.
//

import Foundation
import UIKit

class Homepage {
    
    var stores:[Store] = []
    var category:[Category] = []
    
    init(){
        ////
        self.stores.append(Store(name:"Walmart"))
        self.stores.append(Store(name:"HyVee"))
        self.stores.append(Store(name:"Target"))
        self.stores.append(Store(name:"Sams Club"))
        self.stores.append(Store(name:"Dollar General"))
        
        //        self.category.append(Category(name:"Dairy"))
        //        self.category.append(Category(name:"Meat"))
        //        self.category.append(Category(name:"Vegetables"))
        //        self.category.append(Category(name:"Fruits"))
        //        self.category.append(Category(name:"Health & Beauty"))
        
        
    }
    
    
}