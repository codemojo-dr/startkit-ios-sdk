//
//  ViewController.swift
//  codemojopro
//
//  Created by abservetech on 7/16/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import UIKit
import codemojoframework

class ViewController: UIViewController {

    @IBOutlet weak var textfield1: UITextField!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var Access_token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signup(sender: AnyObject) {
        
        let value = textfield1.text
        
        if value == "" {
            
            let alert = UIAlertController(title: "Message!", message: "Please enter your username/Email Address", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        else {
        
            let username = value!
            
            NSLog("This is our log")
            let log = Codemojoclient()
            
            textfield1.text = ""

            // old 99dd3c74dfbda4c8977743134804c2a04a75f26b
            // my i6CGwzZjRVawx8tOoLzlDRPZPi2vUFmcMZShxRAo
            
            self.appDelegate.env_type = 0
            
            log.getAppSecret("99dd3c74dfbda4c8977743134804c2a04a75f26b", customer_id: username, EnviromentType: 0, completion: {[weak self] (status, access_token) in
                print("status \(status)")
                
                if status == "Success" {
                    
                    print("access_token \(access_token)")
                    
                    self!.Access_token = access_token
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self!.appDelegate.userid = username
                        
                        self?.appDelegate.Access_token = (self?.Access_token)!
                        
                        let viewcontroller = (self?.storyboard?.instantiateViewControllerWithIdentifier("dashboard"))! as UIViewController
                        
                        self?.navigationController?.pushViewController(viewcontroller, animated: true)
                        
                    })
                    
                }
                
            })
            
        }
        
    }
    
}

