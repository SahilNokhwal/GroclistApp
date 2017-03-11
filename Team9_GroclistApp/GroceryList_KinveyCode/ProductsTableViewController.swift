//
//  ProductsTableViewController.swift
//  GroceryList_KinveyCode
//
//  Created by Akkiraju,Prahasith on 4/13/16.
//  Copyright © 2016 Akkiraju,Prahasith. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    var sh : [Shoper]!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Go To List", style: .Plain, target: self, action: "add")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "products")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
         self.tableView.allowsMultipleSelection = true
    }
    
    //the code for the add he item values to the
    func add() {
        let dest =  SummaryTableViewController()
        self.navigationController?.pushViewController(dest, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sh.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCellWithIdentifier("products", forIndexPath: indexPath)
        let cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "products")
        
        cell.textLabel?.text = sh[indexPath.row].product
        cell.detailTextLabel?.text = sh[indexPath.row].price

        return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        let item = sh[indexPath.row].product
        print(sh[indexPath.row].price)
        let str =  sh[indexPath.row].price
        let cost = Double(str.substringWithRange(Range<String.Index>(start: str.startIndex.advancedBy(1), end: str.endIndex)))
        //let img = image[indexPath.row]
        let img  = "red"
        print(item)
        print(cost)
        
        //finalcart.addItems(item, cost: cost)
        cart.addItems(item, cost: cost!, img: img)
        self.view.endEditing(true)
        
    }
    
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        
        let temp = sh[indexPath.row].product
        
        for var i = 0;i < cart.cart.count ;i++ {
            
            if (temp == cart.cart[i].name) {
                cart.cart.removeAtIndex(i)
            }
        }
        
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
//        let item = products[indexPath.row]
//        let cost = price[indexPath.row]
//        let img = image[indexPath.row]
//        print(item)
//        print(cost)
//        
//        //finalcart.addItems(item, cost: cost)
//        cart.addItems(item, cost: cost, img: img)
//        self.view.endEditing(true)
//        
//    }
//    
//    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
//        
//        let temp = products[indexPath.row]
//        
//        for var i = 0;i < cart.cart.count ;i++ {
//            
//            if (temp == cart.cart[i].name) {
//                cart.cart.removeAtIndex(i)
//            }
//        }
//        
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
