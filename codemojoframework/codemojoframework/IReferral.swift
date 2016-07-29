//
//  IReferral.swift
//  codemojoframework
//
//  Created by abservetech on 7/26/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import Foundation

public class IReferral {
    
    var Sandbox_url = "https://sandbox.codemojo.io/"
    
    var Production_url = "https://production.codemojo.io/"
    
    public init() {
        
    }
    
    public func getReferral(customer_id:String, Access_token:String, EnviromentType:Int, completion: (status: String, code:String, url: String, friend_earn: String, you_earn: String) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        let url:NSURL = NSURL(string: urlString+"v1/services/referral/generate/user=\(customer_id)")!
        
        let request = NSMutableURLRequest(URL: url)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod = "PUT"
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        
        
        let manager = APIManager()
        
        manager.Start(request) { (data, response, error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                
                completion(status: "Fail", code: "", url: "", friend_earn: "", you_earn: "")
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("code") != nil {
                            
                            let code = results.objectForKey("code") as! String
                            
                            let url = results.objectForKey("url") as! String
                            
                            if results.objectForKey("reward") != nil {
                                
                                let reward = results.objectForKey("reward") as! NSDictionary
                                
                                let friend_earn = reward.objectForKey("friend") as! String
                                
                                let you_earn = reward.objectForKey("you") as! String
                                
                                completion(status: "Success", code: "\(code)", url: "\(url)", friend_earn: friend_earn, you_earn: you_earn)
                                
                            }
                                
                            else {
                                completion(status: "Success", code: "\(code)", url: "\(url)", friend_earn: "", you_earn: "")
                            }
                            
                        }
                        else {
                            completion(status: "Fail", code: "", url: "", friend_earn: "", you_earn: "")
                        }
                        
                    }
                    else {
                        completion(status: "Fail", code: "", url: "", friend_earn: "", you_earn: "")
                    }
                    
                }
            } catch {
                
                completion(status: "Fail", code: "", url: "", friend_earn: "", you_earn: "")
                
            }
            
        }
        
    }
    
    public func UseReferral(customer_id:String, referralcode:String, Access_token:String, EnviromentType:Int, completion: (status: String, message:String) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        var URL = "v1/services/referral/claim/\(customer_id)/\(referralcode)"
        
        URL = URL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
        
        let url:NSURL = NSURL(string: urlString+"\(URL)")!
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        
        
        let manager = APIManager()
        
        manager.Start(request) { (data, response, error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                
                completion(status: "Fail", message: "")
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    
                    if responseObject["status"] != nil {
                        
                        let status = responseObject["status"] as! String
                        
                        if responseObject["message"] != nil {
                            
                            let message = responseObject["message"] as! String
                            
                            completion(status: "\(status)", message: "\(message)")
                            
                        }
                            
                        else {
                            completion(status: "\(status)", message: "")
                        }
                        
                    }
                    else {
                        completion(status: "Fail", message: "")
                    }
                    
                }
            } catch {
                
                completion(status: "Fail", message: "")
                
            }
            
        }
        
    }
    
    public func claimReferral(customer_id:String, Access_token:String, EnviromentType:Int, completion: (status: String, code:String, url: String, friend_earn: String, you_earn: String) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        let url:NSURL = NSURL(string: urlString+"/v1/services/referral/claim/\(customer_id)")!
        
        let request = NSMutableURLRequest(URL: url)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod = "PUT"
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        
        
        let manager = APIManager()
        
        manager.Start(request) { (data, response, error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                
                completion(status: "Fail", code: "", url: "", friend_earn: "", you_earn: "")
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("code") != nil {
                            
                            let code = results.objectForKey("code") as! String
                            
                            let url = results.objectForKey("url") as! String
                            
                            if results.objectForKey("reward") != nil {
                                
                                let reward = results.objectForKey("reward") as! NSDictionary
                                
                                let friend_earn = reward.objectForKey("friend") as! String
                                
                                let you_earn = reward.objectForKey("you") as! String
                                
                                completion(status: "Success", code: "\(code)", url: "\(url)", friend_earn: friend_earn, you_earn: you_earn)
                                
                            }
                                
                            else {
                                completion(status: "Success", code: "\(code)", url: "\(url)", friend_earn: "", you_earn: "")
                            }
                            
                        }
                        else {
                            completion(status: "Fail", code: "", url: "", friend_earn: "", you_earn: "")
                        }
                        
                    }
                    else {
                        completion(status: "Fail", code: "", url: "", friend_earn: "", you_earn: "")
                    }
                    
                }
            } catch {
                
                completion(status: "Fail", code: "", url: "", friend_earn: "", you_earn: "")
                
            }
            
        }
        
    }
    
}
