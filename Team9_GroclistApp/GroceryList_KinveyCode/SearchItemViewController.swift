//
//  SearchItemViewController.swift
//  Team09_Groclist
//
//  Created by Admin on 4/6/16.
//  Copyright © 2016 Parise,Prem Abishai. All rights reserved.
//

import UIKit

class SearchItemViewController: UIViewController {
    var jsonFetcher:JSONFetcher!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func HomeBTN(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("backhome", sender: self)
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
