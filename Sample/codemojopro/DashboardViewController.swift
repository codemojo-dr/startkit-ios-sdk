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
        
        let log = Codemojoclient()
        
        let userid = appDelegate.userid
        
        log.claimReferral(userid, referralcode: "", Access_token: self.appDelegate.Access_token, EnviromentType: appDelegate.env_type) { (status, code, url, friend_earn, you_earn) in
            
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func exit(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func gotoReferalPage(sender: AnyObject) {
        
        // call framework's viewcontroller for referral view
        
        let frameworkBundle = NSBundle(identifier: "com.abservetech.codemojoframework")
        let storyboard = UIStoryboard(name: "Storyboard", bundle: frameworkBundle)
        
        let viewcontroller = (storyboard.instantiateViewControllerWithIdentifier("referralview")) as UIViewController
        
        // pass data to framework
        
        userid = appDelegate.userid
        Access_token = appDelegate.Access_token
        env_type = appDelegate.env_type
        
        ////////////////////////
        
        self.navigationController?.pushViewController(viewcontroller, animated: true)
        
    }
    
    @IBAction func gotoGamificationAchieve(sender: AnyObject) {
        
        let viewcontroller = (self.storyboard?.instantiateViewControllerWithIdentifier("gamedemo"))! as UIViewController
        
        self.navigationController?.pushViewController(viewcontroller, animated: true)
        
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
