//
//  File.swift
//  codemojoframework
//
//  Created by abservetech on 7/16/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import Foundation

public class mojoconfig {

    var Sandbox_url = "https://sandbox.codemojo.io/"
    
    var Production_url = "https://production.codemojo.io/"
    
    public init() {
        
    }
    
    public func getAppSecret(app_token:String, customer_id:String, EnviromentType:Int, completion: (status: String, access_token: String) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
           urlString = Sandbox_url
        }
        
        else {
           urlString = Production_url
        }
        
        let url:NSURL = NSURL(string: urlString+"oauth/app")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = "app_token=\(app_token)&customer_id=\(customer_id)"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                
                completion(status: "Fail", access_token: "")
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    
                    if responseObject["access_token"] != nil {
                        
                        let access_token = responseObject["access_token"] as! String
                        
                        print("access token \(access_token)")
                        
                        completion(status: "Success", access_token: access_token)
                        
                    }
                    
                }
            } catch {
                print(error)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                completion(status: "Fail", access_token: "")
                
            }
            
        }
        
        task.resume()
        
    }
    
    public func getBalance(customer_id:String, Access_token:String, EnviromentType:Int, completion: (status: String, total: Int, raw: Int, converted: Double) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        var str = "v1/services/wallet/credits/balance/\(customer_id)"
        
        str = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
        
        let url:NSURL = NSURL(string: urlString+"\(str)")!
        
        print("url1 \(url)")
        
        let session1 = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        print("Bearer \(Access_token)")
        
        let task = session1.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                
                completion(status: "Fail", total: 0, raw: 0, converted: 0)
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    print("response \(responseObject)")
                    
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("total") != nil {
                            
                            let total = results.objectForKey("total") as! NSNumber
                            
                            let dict = results.objectForKey("slot3") as! NSDictionary
                            
                            let raw = dict.objectForKey("raw") as! NSNumber
                            
                            let converted = dict.objectForKey("converted") as! NSNumber
                            
                            print("total \(total)")
                            
                            completion(status: "Success", total: total as Int, raw: raw as Int, converted: converted as Double)
                            
                        }
                        else {
                            completion(status: "Fail", total: 0, raw: 0, converted: 0)
                        }
                        
                    }
                    else {
                        completion(status: "Fail", total: 0, raw: 0, converted: 0)
                    }
                    
                }
            } catch {
                print(error)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                completion(status: "Fail", total: 0, raw: 0, converted: 0)
                
            }
            
        }
        
        task.resume()
    }
    
    public func addLoyaltyPoints(customer_id:String, Access_token:String, EnviromentType:Int, completion: (status: String, total: Int) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        let url:NSURL = NSURL(string: urlString+"v1/services/loyalty")!
        
        let request = NSMutableURLRequest(URL: url)
        
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
    
    public func getSummary(customer_id:String, Access_token:String, EnviromentType:Int, completion: (status: String, total: Int) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        var str = "v1/services/gamification/summary/\(customer_id)"
        
        str = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
        
        let url:NSURL = NSURL(string: urlString+"\(str)")!
        
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
        
        let session1 = NSURLSession(configuration:NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
        
        let paramString = "customer_id=\(customer_id)&action_id=\(action_id)&platform_id=\(platform_id)"
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
        
        let session1 = NSURLSession(configuration:NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
        
        let paramString = "customer_id=\(customer_id)&action_id=\(Action_id)&category_id=\(category_id)"
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
        
        let session1 = NSURLSession(configuration:NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
        
        //        let paramString = "user=\(customer_id)"
        //        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        let task = session1.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                
                completion(status: "Fail", code: "", url: "", friend_earn: "", you_earn: "")
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    print("response \(responseObject)")
                    
                    if responseObject["results"] != nil {
                        
                        let results = responseObject["results"] as! NSDictionary
                        
                        if results.objectForKey("code") != nil {
                            
                            let code = results.objectForKey("code") as! String
                            
                            let url = results.objectForKey("url") as! String
                            
                            print("code \(code)")
                            
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
                print(error)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                completion(status: "Fail", code: "", url: "", friend_earn: "", you_earn: "")
                
            }
            
        }
        
        task.resume()
        
    }
    
    public func UseReferral(customer_id:String, referralcode:String, Access_token:String, EnviromentType:Int, completion: (status: String, message:String) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        var str = "v1/services/referral/claim/\(customer_id)/\(referralcode)"
        
        str = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
        
        let url:NSURL = NSURL(string: urlString+"\(str)")!
        
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
                
                completion(status: "Fail", message: "")
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    print("response \(responseObject)")
                    
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
                print(error)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                completion(status: "Fail", message: "")
                
            }
            
        }
        
        task.resume()
    }
   
}