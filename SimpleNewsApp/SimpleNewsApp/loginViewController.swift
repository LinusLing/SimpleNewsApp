//
//  loginViewController.swift
//  SimpleNewsApp
//
//  Created by Linus on 14-12-15.
//  Copyright (c) 2014年 Linus. All rights reserved.
//

import UIKit
import Alamofire

class loginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var pwd: UITextField!
    
    @IBAction func login(sender: AnyObject) {
        var uname = username.text
        var upwd = pwd.text
        Alamofire.request(.GET, "http://newsoflinus.sinaapp.com/check/\(uname)&\(upwd)").responseString() {(_, _, string, _) in
            var i = string!
            if i == "1" {
                println("login")
            }else {
                println("lognotin")
            }
        }
    }
    
    @IBAction func backgroundTouchDown(sender: AnyObject) {
        //移除文本框的焦点
        username.resignFirstResponder()
        pwd.resignFirstResponder()
    }
    @IBAction func usernameDidEndOnExit(sender: AnyObject) {
        pwd.becomeFirstResponder()
    }
    
    @IBAction func pwdDidEndOnExit(sender: AnyObject) {
        login(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
