//
//  Cart.swift
//  Team09_Groclist
//
//  Created by Parise,Prem Abishai on 4/13/16.
//  Copyright © 2016 Parise,Prem Abishai. All rights reserved.
//  edited

import UIKit


var cart:Cart = Cart()

struct Item{
    
    var name = "un-named"
    var cost = 0.0
    var img = "un-named"
}


class Cart: NSObject{
    
     var cart:[Item] = []
    
    
    func addItems(name:String, cost:Double, img:String){
        
        cart.append(Item(name: name, cost: cost, img:img))
    }

    
   
}