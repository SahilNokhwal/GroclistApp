//
//  TableViewController.swift
//  Team09
//
//  Created by Nokhwal,Sahil on 4/13/16.
//  Copyright © 2016 Sahil Nokhwal. All rights reserved.
//


import UIKit



class TableViewController: UITableViewController {

    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    var navTitle:String!

    
    var wallmartData:[Wallmart]! = nil
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell
        
       
        cell = tableView.dequeueReusableCellWithIdentifier("myCell",forIndexPath:indexPath)
        
        
      cell.textLabel!.font = UIFont(name:"Avenir", size:12)
     
        cell.textLabel?.text = wallmartData[indexPath.row].name
       
        
     cell.detailTextLabel?.text = String(format:"$: %0.2f", wallmartData[indexPath.row].salePrice)
         cell.imageView?.image =
            /*        image.image = */                   NSURL(string: wallmartData[indexPath.row].thumbnailImage)
                                                    .flatMap { NSData(contentsOfURL: $0) }
                                                    .flatMap { UIImage(data: $0) }

        return cell
    }
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(navTitle)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "addLeft")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Go To List", style: .Plain, target: self, action: "addTap")
       navigationBarTitle.title = navTitle.capitalizedString
        //print(navTitle)
        self.tableView.allowsMultipleSelection = true
        
        
       // self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "products")
        
    }
   
    func addLeft() {
        print("left")
        let dest =  HomeMenuViewController()
        self.navigationController?.pushViewController(dest, animated: true)
        
    }
    
    
    
    
    func addTap() {
        print("tapped")
        let dest =  SummaryTableViewController()
        self.navigationController?.pushViewController(dest, animated: true)
      
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        let item = wallmartData[indexPath.row].name
        let cost = wallmartData[indexPath.row].salePrice
        let img = wallmartData[indexPath.row].thumbnailImage
        print(item)
        print(cost)
        
        //finalcart.addItems(item, cost: cost)
        cart.addItems(item, cost: cost, img: img)
        self.view.endEditing(true)
        
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        
        let temp = wallmartData[indexPath.row].name
        
        for var i = 0;i < cart.cart.count ;i++ {
            
            if (temp == cart.cart[i].name) {
                cart.cart.removeAtIndex(i)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
   
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(wallmartData.count)
        
        return wallmartData.count
    }
    
    
    
    
}
