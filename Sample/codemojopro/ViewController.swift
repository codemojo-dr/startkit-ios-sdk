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
            let log = mojoconfig()
            
            textfield1.text = ""

            log.getAppSecret("i6CGwzZjRVawx8tOoLzlDRPZPi2vUFmcMZShxRAo", customer_id: username, EnviromentType: 0, completion: {[weak self] (status, access_token) in
                print("status \(status)")
                
                if status == "Success" {
                    
                    print("access_token \(access_token)")
                    
                    self!.Access_token = access_token
                    
                   /* self?.getReferral(username, completion: { (status, total) in
                        
                    }) */
                    
                   /* self!.addAchievement(username, completion: { (status, total) in
                        
                        self?.addAction(username, completion: { (status, total) in
                            
                            self!.getSummary(username, completion: { (status, total) in
                                
                                log.getBalance(username, completion: { (status, total) in
                                    
                                })
                            })
                            
                        })
                        
                    }) */
                    
                    
                    self?.addAction(username, completion: { (status, total) in
                        
                        self!.getSummary(username, completion: { (status, total) in
                            
                        })
                        
                    })
                    
                   /* self!.getSummary(username, completion: { (status, total) in
                        
                        }) */
                    
                  /*  dispatch_async(dispatch_get_main_queue(), {
                        
                        let viewcontroller = (self?.storyboard?.instantiateViewControllerWithIdentifier("dashboard"))! as UIViewController
                        
                        self?.navigationController?.pushViewController(viewcontroller, animated: true)
                        
                    }) */
                    
                }
                
            })
            
//            let viewcontroller = (self.storyboard?.instantiateViewControllerWithIdentifier("dashboard"))! as UIViewController
//            
//            self.navigationController?.pushViewController(viewcontroller, animated: true)
            
        }
        
    }
    
    func addLoyaltyPoints(customer_id:String, completion: (status: String, total: Int) -> Void) {
        
        let url = NSURL(string: "https://sandbox.codemojo.io/v1/services/loyalty")
        
        let request = NSMutableURLRequest(URL: url!)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod = "PUT"
        
        let session1 = NSURLSession(configuration:NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
        
        let paramString = "customer_id=\(customer_id)&transaction=150.0&transaction_id=100"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        let task = session1.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                
                completion(status: "Fail", total: 0)
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    print("response \(responseObject)")
                    
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("total") != nil {
                            
                            let total = results.objectForKey("total") as! NSNumber
                            
                            print("total \(total)")
                            
                            completion(status: "Success", total: total as Int)
                            
                        }
                        else {
                            completion(status: "Fail", total: 0)
                        }
                        
                    }
                    else {
                        completion(status: "Fail", total: 0)
                    }
                    
                }
            } catch {
                print(error)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                completion(status: "Fail", total: 0)
                
            }
            
        }
        
        task.resume()
        
    }
    
    func getReferral(customer_id:String, completion: (status: String, total: Int) -> Void) {
        
        let url = NSURL(string: "https://sandbox.codemojo.io/v1/services/referral/generate/user=\(customer_id)")
        
        let request = NSMutableURLRequest(URL: url!)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod = "PUT"
        
        let session1 = NSURLSession(configuration:NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
        
//        let paramString = "user=\(customer_id)"
//        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        let task = session1.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                
                completion(status: "Fail", total: 0)
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    print("response \(responseObject)")
                    
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("total") != nil {
                            
                            let total = results.objectForKey("total") as! NSNumber
                            
                            print("total \(total)")
                            
                            completion(status: "Success", total: total as Int)
                            
                        }
                        else {
                            completion(status: "Fail", total: 0)
                        }
                        
                    }
                    else {
                        completion(status: "Fail", total: 0)
                    }
                    
                }
            } catch {
                print(error)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                completion(status: "Fail", total: 0)
                
            }
            
        }
        
        task.resume()
        
    }
    
    func getSummary(customer_id:String, completion: (status: String, total: Int) -> Void) {
        
        let urlString = "https://sandbox.codemojo.io/"
        
        let url:NSURL = NSURL(string: urlString+"v1/services/gamification/summary/customer_id=\(customer_id)")!
        
        print("url1 \(url)")
        
        let session1 = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        let task = session1.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                
                completion(status: "Fail", total: 0)
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    print("response \(responseObject)")
                    
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("total") != nil {
                            
                            let total = results.objectForKey("total") as! NSNumber
                            
                            print("total \(total)")
                            
                            completion(status: "Success", total: total as Int)
                            
                        }
                        else {
                            completion(status: "Fail", total: 0)
                        }
                        
                    }
                    else {
                        completion(status: "Fail", total: 0)
                    }
                    
                }
            } catch {
                print(error)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                completion(status: "Fail", total: 0)
                
            }
            
        }
        
        task.resume()
    }
    
    func addAction(customer_id:String, completion: (status: String, total: Int) -> Void) {
        
        let url = NSURL(string: "https://sandbox.codemojo.io/v1/services/gamification")
        
        let request = NSMutableURLRequest(URL: url!)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod = "PUT"
        
        let session1 = NSURLSession(configuration:NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
        
        let paramString = "customer_id=\(customer_id)&action_id=LEADER&platform_id=iOS"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        let task = session1.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                
                completion(status: "Fail", total: 0)
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    print("response \(responseObject)")
                    
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("total") != nil {
                            
                            let total = results.objectForKey("total") as! NSNumber
                            
                            print("total \(total)")
                            
                            completion(status: "Success", total: total as Int)
                            
                        }
                        else {
                            completion(status: "Fail", total: 0)
                        }
                        
                    }
                    else {
                        completion(status: "Fail", total: 0)
                    }
                    
                }
            } catch {
                print(error)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                completion(status: "Fail", total: 0)
                
            }
            
        }
        
        task.resume()
        
    }
    
    func addAchievement(customer_id:String, completion: (status: String, total: Int) -> Void) {
        
        let url = NSURL(string: "https://sandbox.codemojo.io/v1/services/gamification/achievements")
        
        let request = NSMutableURLRequest(URL: url!)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod = "PUT"
        
        let session1 = NSURLSession(configuration:NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
        
        let paramString = "customer_id=\(customer_id)&action_id=100&category_id=1"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        let task = session1.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                
                completion(status: "Fail", total: 0)
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    print("response \(responseObject)")
                    
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("total") != nil {
                            
                            let total = results.objectForKey("total") as! NSNumber
                            
                            print("total \(total)")
                            
                            completion(status: "Success", total: total as Int)
                            
                        }
                        else {
                            completion(status: "Fail", total: 0)
                        }
                        
                    }
                    else {
                        completion(status: "Fail", total: 0)
                    }
                    
                }
            } catch {
                print(error)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                completion(status: "Fail", total: 0)
                
            }
            
        }
        
        task.resume()
        
    }
    
}

