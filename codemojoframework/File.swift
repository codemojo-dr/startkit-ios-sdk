//
//  File.swift
//  codemojoframework
//
//  Created by abservetech on 7/16/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import Foundation

public class mojoconfig {

    var Sandbox_url = "https://sandbox.codemojo.io/oauth/app"
    
    var Production_url = "https://sandbox.codemojo.io/oauth/app"
    
    public init() {
        
    }
    
    public func createReferralCode(username: String, length: Int) -> String {
        
        let allowedChars = "\(username)abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.startIndex.advancedBy(randomNum)]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    public func createloyalitypoint(value: Double, percentage: Double) -> Int {
        
        let percentval = ((value/100)*percentage) as Double
        
        let result = Int(percentval)
        
        return result
    }
    
    public func getAppSecret(app_token:String, customer_id:String, Enviroment:Int, completion: (status: String, access_token: String) -> Void) {
        
        var urlString = ""
        
        if Enviroment == 0 {
           urlString = Sandbox_url
        }
        
        else {
           urlString = Production_url
        }
        
        let url:NSURL = NSURL(string: urlString)!
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
                print("error")
                
                completion(status: "Fail", access_token: "")
                
                return
            }
            
            do {
                if let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    print("response \(responseObject)")
                    
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
}