//
//  HomeTableViewController.swift
//  Team09_Groclist
//
//  Created by Parise,Prem Abishai on 3/15/16.
//  Copyright © 2016 Parise,Prem Abishai. All rights reserved.
//


import UIKit

class HomeTableViewController: UITableViewController {
    
    var homepage:Homepage!
    var jsonFetcher:JSONFetcher!
    var walmart:WalmartModel!
    var categories = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Stores"
        self.navigationItem.rightBarButtonItem?.title = "Search"
        homepage = Homepage()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        jsonFetcher = JSONFetcher() // make our JSONFetcher
        jsonFetcher.fetchJSON("http://api.walmartlabs.com/v1/taxonomy?format=json&apiKey=jqaxentbfgqw9wd8h5f53x2u") // tell it to go to work!
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reloadData:"), name: "Data Delivered", object: nil)
    }
    //function to reload data
    func reloadData(reload:NSNotification){
        tableView.reloadData()
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
        
        return homepage.stores.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("store_cell", forIndexPath: indexPath)
        
        
        // Configure the cell...
        
        //assigning data with respective to cell tags
//        let nameLbl : UILabel = cell.viewWithTag(1) as! UILabel
//        
//        let imageIMG = cell.viewWithTag(2) as! UIImageView
//        nameLbl.text = homepage.stores[indexPath.row].name
//        
//        imageIMG.image = UIImage(named: homepage.stores[indexPath.row].name)
        
        //let cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "product_cell")
        // Configure the cell...
        cell.textLabel?.text = homepage.stores[indexPath.row].name
        
        
        cell.textLabel?.numberOfLines = 2;
        [cell.textLabel? .sizeToFit()];
        //cell.detailTextLabel?.text = "\(String(price[indexPath.row]))$"
        cell.imageView?.image = UIImage(named: homepage.stores[indexPath.row].name)
            
        
        

        
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
        var walmart : CategoryTableViewController = CategoryTableViewController()
        var hts : CategoriesTableViewController = CategoriesTableViewController()
        
        if indexPath.row == 0 {
            walmart.store = homepage.stores[indexPath.row]
            walmart.jsonFetcher = self.jsonFetcher
            //  dest.walmrtmodel = jsonFetcher.categoryName[rowdept]
            // print(self.walmart.category.count)
            for category in jsonFetcher.categoryName{
                print("home")
                print(category.category.count)
            }
            
            self.navigationController?.pushViewController(walmart, animated: true)
        } else {
            hts.name = homepage.stores[indexPath.row].name
            self.navigationController?.pushViewController(hts, animated: true)
        }
        
    }
    
    
    
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "category_segue" {
//            ///if let dest = segue.destinationViewController as? CategoryTableViewController
//            if let dest = segue.destinationViewController as? CategoryTableViewController
//            {
//                if let rowdept = tableView.indexPathForSelectedRow?.row{
//                    print(rowdept)
//                    
//                    
//                    
//                }
//            }
//        }
//    }
    
    
    
    @IBAction func HomeBTN(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("home", sender: self)

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

