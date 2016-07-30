//
//  ReferralViewController.swift
//  codemojopro
//
//  Created by abservetech on 7/25/16.
//  Copyright © 2016 abservetech. All rights reserved.
//

import UIKit

public var userid = ""
public var Access_token = ""
public var env_type:Int = 0
public var referralurl = ""
public var referralcode = ""

public class ReferralViewController: UIViewController, UITextFieldDelegate {

   // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var referraltext: UITextView!
    
    @IBOutlet weak var earnlabel: UILabel!
    
    @IBOutlet weak var entreferraltxt: UITextField!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    weak var activeField: UITextField?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        
        entreferraltxt.delegate = self
        
        let log = Codemojoclient()
        
        log.getReferral(userid, Access_token: Access_token, EnviromentType: env_type) {[weak self] (status, code, url, friend_earn, you_earn) in
            
            dispatch_async(dispatch_get_main_queue(), { 
                self!.referraltext.text = code
            
                referralurl = url
                referralcode = code
                
                print("Your friend will get Rs. \(friend_earn) and you will get Rs. \(you_earn) after their first transaction")
                
                self?.earnlabel.text = "Your friend will get Rs.\(friend_earn) and you will get Rs.\(you_earn) after their first transaction"
                
            })
            
        }
        
        // Do any additional setup after loading the view.
    }

    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override public func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ReferralViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ReferralViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        self.activeField = nil
    }
    
    public func textFieldDidBeginEditing(textField: UITextField) {
        self.activeField = textField
    }
    
    func keyboardDidShow(notification: NSNotification) {
        
        autoreleasepool {
            
            if let activeField = self.activeField, keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
                self.scrollview.contentInset = contentInsets
                self.scrollview.scrollIndicatorInsets = contentInsets
                var aRect:CGRect? = self.view.frame
                aRect!.size.height -= keyboardSize.size.height
                if (!CGRectContainsPoint(aRect!, activeField.frame.origin)) {
                    self.scrollview.scrollRectToVisible(activeField.frame, animated: true)
                }
                aRect = nil
            }
            
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        
        autoreleasepool {
            
            var contentInsets:UIEdgeInsets? = UIEdgeInsetsZero
            self.scrollview.contentInset = contentInsets!
            self.scrollview.scrollIndicatorInsets = contentInsets!
            contentInsets = nil
            
        }
    }
    
    @IBAction func usereferralact(sender: AnyObject) {
        
        let refcode = entreferraltxt.text
        
        let log = Codemojoclient()
        
        if refcode != "" {
            
            log.UseReferral(userid, referralcode: refcode!, Access_token: Access_token, EnviromentType: env_type, completion: { (status, message) in
                
                print("UseReferral status \(status) \(message)")
                
                dispatch_async(dispatch_get_main_queue(), {
                
                    if status == "success" {
                        let alert = UIAlertController(title: "Message!", message: "Referral amount are added", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                    else if message != "" {
                        let alert = UIAlertController(title: "Message!", message: "\(message)", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                    else {
                        let alert = UIAlertController(title: "Message!", message: "Invalid Referral ID", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                })
                
            })
            
        }
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitact(sender: AnyObject) {
    
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func inivitefrnds(sender: AnyObject) {
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [MyStringItemSource()], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class MyStringItemSource: NSObject, UIActivityItemSource {
    
    @objc func activityViewControllerPlaceholderItem(activityViewController: UIActivityViewController) -> AnyObject {
        return ""
    }
    
    @objc func activityViewController(activityViewController: UIActivityViewController, itemForActivityType activityType: String) -> AnyObject? {
        
        return "Hi there, I have been using Codemojo Demo and fiund it very useful. \n Would be great if you can join me by clicking \(referralurl) or use the cde \(referralcode)"
    }
    
    func activityViewController(activityViewController: UIActivityViewController, subjectForActivityType activityType: String?) -> String {
        
        return "Try out the app Codemojo Demo"
    }
    
}
