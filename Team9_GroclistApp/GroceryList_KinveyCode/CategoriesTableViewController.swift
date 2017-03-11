//
//  CategoriesTableViewController.swift
//  GroceryList_KinveyCode
//
//  Created by Akkiraju,Prahasith on 4/13/16.
//  Copyright © 2016 Akkiraju,Prahasith. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    var store : KCSAppdataStore!
    var jsp : JsonTarget!
    var name : String!
    var selectdshoper : [Shoper] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Categories"
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "categories")
        register()
        loginUser()
        
        jsp = JsonTarget()
        if name == "Sams Club" {
            name = "Sams"
        }
        
        
        if name == "Dollar General" {
            name = "Dollar"
        }
        jsp.name = name
        print(jsp.cat_name.categoryname)
        
        
        
        
        
        //print(cat_name.categoryname.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:
            Selector("reload:"), name: "Data Send", object: nil)
       
    }
    func reload(nsf : NSNotificationCenter)  {
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(animated: Bool) {
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
        //print(jsp.cat_name.categoryname.count)
        return jsp.cat_name.categoryname.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categories", forIndexPath: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = jsp.cat_name.categoryname[indexPath.row]
        

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
        self.selectdshoper.removeAll()
        let destination = ProductsTableViewController()
        let row = tableView.indexPathForSelectedRow?.row
        for s in jsp.sh {
            if row == s.id {
                selectdshoper.append(s)
            }
        }
        destination.sh = selectdshoper
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        self.selectdshoper.removeAll()
//        let destination = segue.destinationViewController as! ProductsTableViewController
//        let row = tableView.indexPathForSelectedRow?.row
//        for s in jsp.sh {
//            if row == s.id {
//                selectdshoper.append(s)
//            }
//        }
//        destination.sh = selectdshoper
//        
//        
//        
//        // Pass the selected object to the new view controller.
//    }
    
    
    
    // code for registering the user
    func register(){
        KCSUser.userWithUsername(
            "kinvey", // making up bogus data -- what you *should* use is usernameTF.text! and passwordTF.text!
            password: "12345",
            fieldsAndValues: [
                KCSUserAttributeEmail : "kinvey@kinvey.com",
                KCSUserAttributeGivenname : "Arnold",
                KCSUserAttributeSurname : "Kinvey"
            ],
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //was successful!
                    print("account created")
                } else {
                    //there was an error with the update save
                    _ = errorOrNil.localizedDescription
                    print("Account in use")
                }
            }
        )
    }
    // code for logging in the user
    func loginUser() {
        
        
        KCSUser.loginWithUsername(
            "kinvey",
            password: "12345",
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //the log-in was successful and the user is now the active user and credentials saved
                    print("Login successful")
                    self.jsp.shopper()
                    //hide log-in view and show main app content
                } else {
                    //there was an error with the update save
                    //let message = errorOrNil.localizedDescription
                    print("login failed")
                }
            }
        )
    }

}
