//
//  userMainViewController.swift
//  SimpleNewsApp
//
//  Created by Linus on 14-12-17.
//  Copyright (c) 2014年 Linus. All rights reserved.
//

import UIKit

class userMainViewController: UIViewController {
    var uname = NSString()
    var upower = NSString()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.setHidesBackButton(true, animated: true)
        var alert = UIAlertView(title: "right", message: "welcome \(uname) and your power is \(upower)", delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
