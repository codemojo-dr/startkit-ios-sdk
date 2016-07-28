//
//  NetworkManager.swift
//  codemojoframework
//
//  Created by abservetech on 7/28/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import Foundation

public class APIManager {
    
    public func Start(request:NSMutableURLRequest, completion: (data: NSData?, response:NSURLResponse?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            completion(data: data,response: response, error: error)
            
        }
        
        task.resume()
        
    }
    
}