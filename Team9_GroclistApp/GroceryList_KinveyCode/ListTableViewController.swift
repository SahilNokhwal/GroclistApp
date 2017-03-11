//
//  ListTableViewController.swift
//  Parise_Groclist
//
//  Created by Abishai Parise on 3/12/16.
//  Copyright © 2016 Abishai Parise. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    var store:Store!
    var category:Category!
    var selectedrow:String!
    var jsonFetcher:JSONFetcher!
    var subcategory:[Subcategory] = []
    var subcatDictionary:[SubcatDictionary]!
    var keys:[String]!
    var values:[String]!
    var selectedvalue:String!
    var products:[String]!
    var price:[Double]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "list_cell")
        self.navigationItem.title = "Sub Categories"
        subcatDictionary = []
        
        fetchdata()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func fetchdata(){
        for category in jsonFetcher.categoryName{
            
            for subcat in category.subcategory {
                // subcategory.append(subcat)
                if(selectedrow == subcat.catId){
                    //                    print("Correct")
                    //                    print(subcat.catId)
                    for subcatdic in subcat.namesMap {
                        
                        subcatDictionary.append(subcatdic)
                        //                    print(subcatdic.name)
                        //                    print("end")
                    }
                }
            }
        }
        
        
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
        
        
        return subcatDictionary.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("list_cell", forIndexPath: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        // Configure the cell...
        
        cell.textLabel?.text = subcatDictionary[indexPath.row].name
        //cell.textLabel?.text = "hello"
        
        // print(cell.textLabel?.text)
        
        
        return cell
    }
    
    
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dest = ProductTableViewController()
        if let rowdept = tableView.indexPathForSelectedRow?.row{
            dest.subcatID = subcatDictionary[rowdept].subcatId
            dest.jsonFetcher = self.jsonFetcher
            //  self.jsonFetcher.productName = []
            print(dest.subcatID)
            
            //                    let url:String = "http://api.walmartlabs.com/v1/paginated/items?category="+dest.subcatID+"&apiKey=jqaxentbfgqw9wd8h5f53x2u&format=json"
            //                    //                    //        //sample url : http://api.walmartlabs.com/v1/paginated/items?category=976759_976779_1044106&apiKey=jqaxentbfgqw9wd8h5f53x2u&format=json
            
            
        }
        self.navigationController?.pushViewController(dest, animated: true)
        
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "product_segue" {
//            
//            if let dest = segue.destinationViewController as? ProductTableViewController
//            {
//                if let rowdept = tableView.indexPathForSelectedRow?.row{
//                    dest.subcatID = subcatDictionary[rowdept].subcatId
//                    dest.jsonFetcher = self.jsonFetcher
//                    //  self.jsonFetcher.productName = []
//                    print(dest.subcatID)
//                    
////                    let url:String = "http://api.walmartlabs.com/v1/paginated/items?category="+dest.subcatID+"&apiKey=jqaxentbfgqw9wd8h5f53x2u&format=json"
////                    //                    //        //sample url : http://api.walmartlabs.com/v1/paginated/items?category=976759_976779_1044106&apiKey=jqaxentbfgqw9wd8h5f53x2u&format=json
//
//                    
//                }
//            }
//        }
//    }
    
    
    

    func fetchproductdata(){
        print("inside fetch data")
        print(jsonFetcher.prod.count)
        self.products = []
        self.price = []
        for product in jsonFetcher.prod{
            print("inside main for")
            
            print(product.itemName)
            products.append(product.itemName)
            price.append(product.salePrice)
            
        }
        
        
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
