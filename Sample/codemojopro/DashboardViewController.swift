//
//  DashboardViewController.swift
//  codemojopro
//
//  Created by abservetech on 7/16/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import UIKit
import codemojoframework

class DashboardViewController: UIViewController {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var refferalcodetxt: UITextField!
    @IBOutlet weak var purchasetxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refferalcodetxt.text = appDelegate.referralcode
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func exit(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func calpoint(sender: AnyObject) {
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
