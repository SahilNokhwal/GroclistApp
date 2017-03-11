//
//  ProductTableViewController.swift
//  Parise_Groclist
//
//  Created by Abishai Parise on 3/15/16.
//  Copyright © 2016 Abishai Parise. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController {
    var subcatID:String!
    var jsonFetcher:JSONFetcher!
    var products:[String]! = []
    var price:[Double]! = []
    var image:[String]! = []
    var tappedItems:[SelectedItems]! = []
    var selected:SelectedItems!
   // var finalcart:Cart!
    
    /// View which contains the loading text and the spinner
    let loadingView = UIView()
    
    /// Spinner shown during load the TableView
    let spinner = UIActivityIndicatorView()
    
    /// Text shown during load the TableView
    let loadingLabel = UILabel()
   
    override func viewDidLoad() {
        //fetchdata()
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Go To list", style: .Plain, target: self, action: "addTapped")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "product_cell")
        self.setLoadingScreen()
        
                let url:String = "http://api.walmartlabs.com/v1/paginated/items?category="+subcatID+"&apiKey=jqaxentbfgqw9wd8h5f53x2u&format=json"
        //        //sample url : http://api.walmartlabs.com/v1/paginated/items?category=976759_976779_1044106&apiKey=jqaxentbfgqw9wd8h5f53x2u&format=json
                jsonFetcher.fetchProductJSON(url) // tell it to go to work!
        //
        self.fetchproductdata()
              // NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reloads:"), name: "Datas", object: nil)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
         self.tableView.allowsMultipleSelection = true
    }
    
    func addTapped() {
        print("tapping")
         let dest =  SummaryTableViewController()
         self.navigationController?.pushViewController(dest, animated: true)
        
    }
    
    func fetchproductdata(){
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            
            //self.rows = ["Row 1", "Row 2", "Row 3", "Row 4", "Row 5"]
            
            print("inside fetch data")
            print(self.jsonFetcher.prod.count)
            self.products = []
            self.price = []
            self.image = []
            for product in self.jsonFetcher.prod{
                print("inside main for")
                
                print(product.itemName)
                self.products.append(product.itemName)
                self.price.append(product.salePrice)
                self.image.append(product.imageUrl)
                
            }
            
            self.tableView.reloadData()
            self.tableView.separatorStyle = .SingleLine
            self.removeLoadingScreen()
            
        }

     
        
       
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //jsonFetcher = JSONFetcher() // make our JSONFetcher
        //        let url:String = "http://api.walmartlabs.com/v1/paginated/items?category="+subcatID+"&apiKey=jqaxentbfgqw9wd8h5f53x2u&format=json"
        ////        //sample url : http://api.walmartlabs.com/v1/paginated/items?category=976759_976779_1044106&apiKey=jqaxentbfgqw9wd8h5f53x2u&format=json
        //        jsonFetcher.fetchProductJSON(url) // tell it to go to work!
        ////
        // fetchdata()
        //       NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reloadData:"), name: "Data Delivered", object: nil)
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
        print(products.count)
        // print(jsonFetcher.productName.count)
        return products.count
        //return jsonFetcher.productName.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("product_cell", forIndexPath: indexPath)
        let cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "product_cell")
        // Configure the cell...
        cell.textLabel?.text = products[indexPath.row]
       
        
        cell.textLabel?.numberOfLines = 2;
         [cell.textLabel? .sizeToFit()];
        cell.detailTextLabel?.text = "\(String(price[indexPath.row]))$"
        cell.imageView?.image =
            
            NSURL(string: image[indexPath.row])
                
                .flatMap { NSData(contentsOfURL: $0) }
                
                .flatMap { UIImage(data: $0) }
        

        
        
    
      
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        let item = products[indexPath.row]
        let cost = price[indexPath.row]
        let img = image[indexPath.row]
        print(item)
        print(cost)
    
        //finalcart.addItems(item, cost: cost)
        cart.addItems(item, cost: cost, img: img)
        self.view.endEditing(true)
        
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        
        let temp = products[indexPath.row]
        
        for var i = 0;i < cart.cart.count ;i++ {
        
            if (temp == cart.cart[i].name) {
        cart.cart.removeAtIndex(i)
            }
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "finalList" {
            
            if let dest = segue.destinationViewController as? SummaryTableViewController
            {
                if let rowdept = tableView.indexPathForSelectedRow?.row{}
                
                //dest.tapped = self.tappedItems
               // dest.finalcart = self.finalcart
                   // dest.subcatID = subcatDictionary[rowdept].subcatId
                  //  dest.jsonFetcher = self.jsonFetcher
                    //  self.jsonFetcher.productName = []
                   // print(dest.subcatID)
      
                
            }
        }
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    private func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (self.tableView.frame.width / 2) - (width / 2)
        let y = (self.tableView.frame.height / 2) - (height / 2) - (self.navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRectMake(x, y, width, height)
        
        // Sets loading text
        self.loadingLabel.textColor = UIColor.grayColor()
        self.loadingLabel.textAlignment = NSTextAlignment.Center
        self.loadingLabel.text = "Loading..."
        self.loadingLabel.frame = CGRectMake(0, 0, 140, 30)
        
        // Sets spinner
        self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.spinner.frame = CGRectMake(0, 0, 30, 30)
        self.spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(self.spinner)
       loadingView.addSubview(self.loadingLabel)
        
        self.tableView.addSubview(loadingView)
        
    }
    
    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        self.spinner.stopAnimating()
        self.loadingLabel.hidden = true
        
    }
    
}
