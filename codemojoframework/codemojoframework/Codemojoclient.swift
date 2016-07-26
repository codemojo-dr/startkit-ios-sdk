//
//  Codemojoclient.swift
//  codemojoframework
//
//  Created by abservetech on 7/26/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import Foundation

public class Codemojoclient {
    
    var Sandbox_url = "https://sandbox.codemojo.io/"
    
    var Production_url = "https://production.codemojo.io/"
    
    public init() {
        
    }
    
    public func getAppSecret(app_token:String, customer_id:String, EnviromentType:Int, completion: (status: String, access_token: String) -> Void) {
        
        let AccessToken = IAccessToken()
        
        AccessToken.getAppSecret(app_token, customer_id: customer_id, EnviromentType: EnviromentType) { (status, access_token) in
            completion(status: status, access_token: access_token)
        }
        
    }
    
    public func getBalance(customer_id:String, Access_token:String, EnviromentType:Int, completion: (status: String, total: Int, raw: Int, converted: Double) -> Void) {
       
        let Wallet = IWallet()
        
        Wallet.getBalance(customer_id, Access_token: Access_token, EnviromentType: EnviromentType) { (status, total, raw, converted) in
            completion(status: status, total: total, raw: raw, converted: converted)
        }
       
    }
    
    public func addLoyaltyPoints(customer_id:String, Access_token:String, EnviromentType:Int, completion: (status: String, total: Int) -> Void) {
        
        let Loyalty = ILoyalty()
        
        Loyalty.addLoyaltyPoints(customer_id, Access_token: Access_token, EnviromentType: EnviromentType) { (status, total) in
            completion(status: status, total: total)
        }
        
    }
    
    public func getSummary(customer_id:String, Access_token:String, EnviromentType:Int, completion: (status: String, total: Int) -> Void) {
        
        let Gamification = IGamification()
        
        Gamification.getSummary(customer_id, Access_token: Access_token, EnviromentType: EnviromentType) { (status, total) in
            completion(status: status, total: total)
        }
        
    }
    
    public func addAction(customer_id:String, Access_token:String, EnviromentType:Int, action_id:String, platform_id:String, completion: (status: String, total: Int) -> Void) {
        
        let Gamification = IGamification()
        
        Gamification.addAction(customer_id, Access_token: Access_token, EnviromentType: EnviromentType, action_id: action_id, platform_id: platform_id) { (status, total) in
            completion(status: status, total: total)
        }
        
    }
    
    public func addAchievement(customer_id:String, Access_token:String, EnviromentType:Int, Action_id:String, category_id:String, completion: (status: String, total: Int) -> Void) {
        
        let Gamification = IGamification()
        
        Gamification.addAchievement(customer_id, Access_token: Access_token, EnviromentType: EnviromentType, Action_id: Action_id, category_id: category_id) { (status, total) in
            completion(status: status, total: total)
        }
    }
    
    public func getReferral(customer_id:String, Access_token:String, EnviromentType:Int, completion: (status: String, code:String, url: String, friend_earn: String, you_earn: String) -> Void) {
        
        let Referral = IReferral()
        
        Referral.getReferral(customer_id, Access_token: Access_token, EnviromentType: EnviromentType) { (status, code, url, friend_earn, you_earn) in
            completion(status: status, code: code, url: url, friend_earn: friend_earn, you_earn: you_earn)
        }
        
    }
    
    public func UseReferral(customer_id:String, referralcode:String, Access_token:String, EnviromentType:Int, completion: (status: String, message:String) -> Void) {
        
        let Referral = IReferral()
        
        Referral.UseReferral(customer_id, referralcode: referralcode, Access_token: Access_token, EnviromentType: EnviromentType) { (status, message) in
            completion(status: status, message: message)
        }
        
    }
    
}
