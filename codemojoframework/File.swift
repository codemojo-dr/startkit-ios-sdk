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
    
    var Access_token = ""
    
    var Environment:Int = 0
    
    public init() {
        
    }
    
    public func getAppSecret(app_token:String, customer_id:String, EnviromentType:Int, completion: (status: String, access_token: String) -> Void) {
        
        var urlString = ""
        
        self.Environment = EnviromentType
        
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
                        
                        self.Access_token = access_token
                        
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
    
    public func getBalance(customer_id:String, completion: (status: String, total: Int) -> Void) {
        
        var urlString = ""
        
        if Environment == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        let url:NSURL = NSURL(string: urlString+"v1/services/wallet/credits/balance/user=\(customer_id)")!
        
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
   
}