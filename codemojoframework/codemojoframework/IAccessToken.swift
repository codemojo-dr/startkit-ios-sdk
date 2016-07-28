//
//  IAccessToken.swift
//  codemojoframework
//
//  Created by abservetech on 7/26/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import Foundation

public class IAccessToken {
    
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
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = "app_token=\(app_token)&customer_id=\(customer_id)"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        
        
        
        let manager = APIManager()
        
        manager.Start(request) { (data, response, error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                
                completion(status: "Fail", access_token: "")
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    
                    if responseObject["access_token"] != nil {
                        
                        let access_token = responseObject["access_token"] as! String
                        
                        completion(status: "Success", access_token: access_token)
                        
                    }
                    
                }
            } catch {
                
                completion(status: "Fail", access_token: "")
                
            }
            
        }
        
        
        
    }
    
}
