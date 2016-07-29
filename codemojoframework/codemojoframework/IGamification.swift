//
//  IGamification.swift
//  codemojoframework
//
//  Created by abservetech on 7/26/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import Foundation

public class IGamification {
    
    var Sandbox_url = "https://sandbox.codemojo.io/"
    
    var Production_url = "https://production.codemojo.io/"
    
    public init() {
        
    }
    
    public func getSummary(customer_id:String, Access_token:String, EnviromentType:Int, completion: (status: String, total: Int) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        var URL = "v1/services/gamification/summary/\(customer_id)"
        
        URL = URL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
        
        let url:NSURL = NSURL(string: urlString+"\(URL)")!
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        
        
        let manager = APIManager()
        
        manager.Start(request) { (data, response, error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                
                completion(status: "Fail", total: 0)
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                   
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("total") != nil {
                            
                            let total = results.objectForKey("total") as! NSNumber
                            
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
                
                completion(status: "Fail", total: 0)
                
            }
            
        }
        
    }
    
    public func addAction(customer_id:String, Access_token:String, EnviromentType:Int, action_id:String, platform_id:String, completion: (status: String, total: Int) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        let url:NSURL = NSURL(string: urlString+"v1/services/gamification")!
        
        let request = NSMutableURLRequest(URL: url)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod = "PUT"
        
        let paramString = "customer_id=\(customer_id)&action_id=\(action_id)&platform_id=\(platform_id)"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        
        
        let manager = APIManager()
        
        manager.Start(request) { (data, response, error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
               
                completion(status: "Fail", total: 0)
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("total") != nil {
                            
                            let total = results.objectForKey("total") as! NSNumber
                            
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
                
                completion(status: "Fail", total: 0)
                
            }
            
        }
        
    }
    
    public func addAchievement(customer_id:String, Access_token:String, EnviromentType:Int, Action_id:String, category_id:String, completion: (status: String, total: Int) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        let url:NSURL = NSURL(string: urlString+"v1/services/gamification/achievements")!
        
        let request = NSMutableURLRequest(URL: url)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod = "PUT"
        
        let paramString = "customer_id=\(customer_id)&action_id=\(Action_id)&category_id=\(category_id)"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        
        
        let manager = APIManager()
        
        manager.Start(request) { (data, response, error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                
                completion(status: "Fail", total: 0)
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                   
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("total") != nil {
                            
                            let total = results.objectForKey("total") as! NSNumber
                            
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
                
                completion(status: "Fail", total: 0)
                
            }
            
        }
        
    }
    
}
