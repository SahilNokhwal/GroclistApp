//
//  HomeMenuViewController.swift
//  Team09_Groclist
//
//  Created by Admin on 4/4/16.
//  Copyright © 2016 Parise,Prem Abishai. All rights reserved.
//

import UIKit

class HomeMenuViewController: UIViewController {
    
    var homepage:Homepage!
    var jsonFetcher:JSONFetcher!
    var walmart:WalmartModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBarHidden = true
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgimg.jpg")!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        jsonFetcher = JSONFetcher() // make our JSONFetcher
        jsonFetcher.fetchJSON("http://api.walmartlabs.com/v1/taxonomy?format=json&apiKey=jqaxentbfgqw9wd8h5f53x2u") // tell it to go to work!
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reloadData:"), name: "Data Delivered", object: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "browseitems" {
            ///if let dest = segue.destinationViewController as? CategoryTableViewController
            if let dest = segue.destinationViewController as? HomeTableViewController {
            
                dest.jsonFetcher = self.jsonFetcher
            }
      
        }else if segue.identifier == "searchitems"{
            
             let dest =  ViewController()
                self.navigationController?.pushViewController(dest, animated: true)
                //dest.jsonFetcher = self.jsonFetcher
            
            
        }
    }


}
