//
//  loginViewController.swift
//  SimpleNewsApp
//
//  Created by Linus on 14-12-15.
//  Copyright (c) 2014年 Linus. All rights reserved.
//

import UIKit


class loginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var pwd: UITextField!
    
    @IBAction func login(sender: AnyObject) {
//        var uname = username.text
//        var upwd = pwd.text
//        var url : URLStringConvertible = "http://newsoflinus.sinaapp.com/check/\(uname)&\(upwd)"
//        println(url)
//        Alamofire.request(.GET, url)
//            .responseJSON { (_, _, JSON, _) in
//                var json = JSON! as NSArray
//                if json.count == 0 {
//                    var alert = UIAlertView(title: "出错", message: "登录出错，帐号或密码错误", delegate: self, cancelButtonTitle: "OK")
//                    alert.show()
//                    println("lognotin")
//                }else {
//                    var uname = json[0] as NSString
//                    var upower = json[1] as NSString
//                    let userMainViewControllerIdentifier = "userMain"
//                    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//                    let userMainView: userMainViewController = storyboard.instantiateViewControllerWithIdentifier(userMainViewControllerIdentifier) as userMainViewController
//                    userMainView.uname = uname
//                    userMainView.upower = upower
//                    self.navigationController?.pushViewController(userMainView, animated: true)
//                }
//        }
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
