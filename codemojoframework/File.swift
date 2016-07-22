//
//  File.swift
//  codemojoframework
//
//  Created by abservetech on 7/16/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import Foundation

public class mojoconfig {

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
}