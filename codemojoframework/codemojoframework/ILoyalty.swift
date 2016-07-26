//
//  ILoyalty.swift
//  codemojoframework
//
//  Created by abservetech on 7/26/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import Foundation

public class ILoyalty {
    
    var Sandbox_url = "https://sandbox.codemojo.io/"
    
    var Production_url = "https://production.codemojo.io/"
    
    public init() {
        
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
        
        let session = NSURLSession(configuration:NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
        
        let paramString = "customer_id=\(customer_id)&transaction=150.0&transaction_id=100"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        let task = session.dataTaskWithRequest(request) {
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
