//
//  IWallet.swift
//  codemojoframework
//
//  Created by abservetech on 7/26/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import Foundation

public class IWallet {
    
    var Sandbox_url = "https://sandbox.codemojo.io/"
    
    var Production_url = "https://production.codemojo.io/"
    
    public init() {
        
    }
    
    public func getBalance(customer_id:String, Access_token:String, EnviromentType:Int, completion: (status: String, total: Int, raw: Int, converted: Double) -> Void) {
        
        var urlString = ""
        
        if EnviromentType == 0 {
            urlString = Sandbox_url
        }
            
        else {
            urlString = Production_url
        }
        
        var URL = "v1/services/wallet/credits/balance/\(customer_id)"
        
        URL = URL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
        
        let url:NSURL = NSURL(string: urlString+"\(URL)")!
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        request.setValue("Bearer "+Access_token, forHTTPHeaderField: "Authorization")
        
        print("Bearer \(Access_token)")
        
        let task = session.dataTaskWithRequest(request) {
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
    
}
