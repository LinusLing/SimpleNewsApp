//
//  aboutViewController.swift
//  SimpleNewsApp
//
//  Created by Linus on 14-12-12.
//  Copyright (c) 2014年 Linus. All rights reserved.
//

import UIKit

class aboutViewController: UIViewController {
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var weibo: UILabel!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    
    @IBAction func address(sender: AnyObject) {
        println("address")
        let addr : NSString = address.text!
        UIApplication.sharedApplication().openURL(NSURL(string: addr)!)
    }
    @IBAction func weibo(sender: AnyObject) {
        println("weibo")
        let webo : NSString = weibo.text!
        UIApplication.sharedApplication().openURL(NSURL(string: webo)!)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("about")
        self.address.userInteractionEnabled = true
        self.weibo.userInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
