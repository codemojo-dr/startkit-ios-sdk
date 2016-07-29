//
//  GamificationdemoViewController.swift
//  codemojopro
//
//  Created by abservetech on 7/25/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import UIKit
import codemojoframework

class GamificationdemoViewController: UIViewController {

    @IBOutlet weak var balancetxt: UILabel!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userid = appDelegate.userid
        
        let log = Codemojoclient()
        
        log.getBalance(userid,Access_token: self.appDelegate.Access_token, EnviromentType: appDelegate.env_type) {[weak self] (status, total, raw, converted) in
            
            print("\(raw) pts = \(converted)")
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self!.balancetxt.text = "\(raw) pts = \(converted)"
                
            })

        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gotoback(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func unoact(sender: AnyObject) {
        
        let log = Codemojoclient()
        
        let userid = appDelegate.userid
        
        log.addAchievement(userid, Access_token: self.appDelegate.Access_token, EnviromentType: appDelegate.env_type, Action_id: "uno", category_id: "") { (status, total) in
            
            log.getBalance(userid,Access_token: self.appDelegate.Access_token, EnviromentType: self.appDelegate.env_type) {[weak self] (status, total, raw, converted) in
                
                print("\(raw) pts = \(converted)")
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self!.balancetxt.text = "\(raw) pts = \(converted)"
                    
                })
                
            }
            
        }
        
    }
    
    @IBAction func startedact(sender: AnyObject) {
        
        let log = Codemojoclient()
        
        let userid = appDelegate.userid
        
        log.addAchievement(userid, Access_token: self.appDelegate.Access_token, EnviromentType: appDelegate.env_type, Action_id: "start", category_id: "") { (status, total) in
            
            log.getBalance(userid,Access_token: self.appDelegate.Access_token, EnviromentType: self.appDelegate.env_type) {[weak self] (status, total, raw, converted) in
                
                print("\(raw) pts = \(converted)")
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self!.balancetxt.text = "\(raw) pts = \(converted)"
                    
                })
                
            }
            
        }
        
    }
    
    @IBAction func communityact(sender: AnyObject) {
        
        let log = Codemojoclient()
        
        let userid = appDelegate.userid
        
        log.addAchievement(userid, Access_token: self.appDelegate.Access_token, EnviromentType: appDelegate.env_type, Action_id: "community", category_id: "") { (status, total) in
            
            log.getBalance(userid,Access_token: self.appDelegate.Access_token, EnviromentType: self.appDelegate.env_type) {[weak self] (status, total, raw, converted) in
                
                print("\(raw) pts = \(converted)")
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self!.balancetxt.text = "\(raw) pts = \(converted)"
                    
                })
                
            }
            
        }
        
        
    }
    
    @IBAction func leaderact(sender: AnyObject) {
        
        let log = Codemojoclient()
        
        let userid = appDelegate.userid
        
        log.addAchievement(userid, Access_token: self.appDelegate.Access_token, EnviromentType: appDelegate.env_type, Action_id: "leader", category_id: "") { (status, total) in
         
            log.getBalance(userid,Access_token: self.appDelegate.Access_token, EnviromentType: self.appDelegate.env_type
            ) {[weak self] (status, total, raw, converted) in
                
                print("\(raw) pts = \(converted)")
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self!.balancetxt.text = "\(raw) pts = \(converted)"
                    
                })
                
            }
            
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
