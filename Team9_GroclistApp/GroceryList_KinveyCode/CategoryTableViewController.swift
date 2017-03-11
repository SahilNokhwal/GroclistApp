//
//  CategoryTableViewController.swift
//  Team09_Groclist
//
//  Created by Parise,Prem Abishai on 3/15/16.
//  Copyright © 2016 Parise,Prem Abishai. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    var store:Store!
    var homepage:Homepage!
    var jsonFetcher:JSONFetcher!
    var walmrtmodel:WalmartModel!
    var categories:[Category] = [] //categories in this view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "category_cell")
        self.navigationItem.title = "Categories"
        fetchdata()
        //        homepage = Homepage()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reloadData:"), name: "Data Delivered", object: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func fetchdata(){
        for category in jsonFetcher.categoryName{
            
            // print(category.category.count)
            
            for cat in category.category {
                print(cat.names)
                categories.append(cat)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //function to reload data
    func reloadData(reload:NSNotification){
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        print(categories.count)
        return categories.count
        
        
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("category_cell", forIndexPath: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        // Configure the cell...
        
        
        //assigning data with respective to cell tags
        //let nameLbl : UILabel = cell.viewWithTag(4) as! UILabel
        
        //let imageIMG = cell.viewWithTag(3) as! UIImageView
        cell.textLabel?.text = categories[indexPath.row].names
        
        
        print(cell.textLabel?.text)
        
        
        
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
        let dest = ListTableViewController()
        
                if let rowdept = tableView.indexPathForSelectedRow?.row {
                    dest.selectedrow = categories[rowdept].id
                    dest.jsonFetcher = self.jsonFetcher
                    // dest.walmrtmodel = jsonFetcher.categoryName[rowdept]
                    for subcat in jsonFetcher.categoryName {
                        for sub in subcat.subcategory {
                            print(sub.namesMap)
                        }
                    }
                }
        self.navigationController?.pushViewController(dest, animated: true)
        
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "list_segue" {
//            if let dest = segue.destinationViewController as? ListTableViewController
//            {
//                if let rowdept = tableView.indexPathForSelectedRow?.row{
//                    dest.selectedrow = categories[rowdept].id
//                    dest.jsonFetcher = self.jsonFetcher
//                    // dest.walmrtmodel = jsonFetcher.categoryName[rowdept]
//                    for subcat in jsonFetcher.categoryName {
//                        for sub in subcat.subcategory {
//                            print(sub.namesMap)
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

