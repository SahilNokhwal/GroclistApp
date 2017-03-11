//
//  SummaryTableViewController.swift
//  Team09_Groclist
//
//  Created by Parise,Prem Abishai on 3/15/16.
//  Copyright © 2016 Parise,Prem Abishai. All rights reserved.
//

import UIKit
import MessageUI
class SummaryTableViewController: UITableViewController ,MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var email: UIBarButtonItem!
    func sendemail() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    var tapped:[SelectedItems]! = []
     var finalcart:Cart!
    
    /// View which contains the loading text and the spinner
    let loadingView = UIView()
    
    /// Spinner shown during load the TableView
    let spinner = UIActivityIndicatorView()
    
    /// Text shown during load the TableView
    let loadingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 44.0
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send Email", style: .Plain, target: self, action: "sendemail")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "finalitems")
         //self.setLoadingScreen()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.fetchproductdata()
      
       
    }
    
    func fetchproductdata(){
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            
            //self.rows = ["Row 1", "Row 2", "Row 3", "Row 4", "Row 5"]
           
            print("inside fetch data")
            
//            for cart in self.finalcart.cart {
//                self.tapped.append(cart)
//            }
            print(cart.cart.count)
            
            self.tableView.reloadData()
            self.tableView.separatorStyle = .SingleLine
           // self.removeLoadingScreen()
            
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
        print(tapped.count)
        return cart.cart.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("finalitems", forIndexPath: indexPath)
        let cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "finalitems")
        // Configure the cell...
        cell.textLabel?.text = cart.cart[indexPath.row].name
        
        
        cell.textLabel?.numberOfLines = 2;
        [cell.textLabel? .sizeToFit()];
        cell.detailTextLabel?.text = "\(String(cart.cart[indexPath.row].cost))$"
        
        cell.imageView?.image =
            
            NSURL(string: cart.cart[indexPath.row].img)
                
                .flatMap { NSData(contentsOfURL: $0) }
                
                .flatMap { UIImage(data: $0) }

        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        
        
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
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["abhishai4u@gmail.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        
        var finalmail:String = ""
        
        for item in cart.cart {
            
            finalmail = finalmail + "\(item.name)    \(item.cost) \n"
        }
        
        mailComposerVC.setMessageBody("Grocery List  \n \(finalmail)", isHTML: false)
        
        print(finalmail)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }


}
