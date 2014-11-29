//
//  WebViewController.swift
//  SimpleNewsApp
//
//  Created by Linus on 14-11-29.
//  Copyright (c) 2014年 Linus. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    var detailID = NSString()
    var detailURL = "http://qingbin.sinaapp.com/api/html/"
    var webView : UIWebView?
    
    func loadDataSource() {
        var urlString = detailURL + "\(detailID).html"
        var url = NSURL(string: urlString)
        var urlRequest = NSURLRequest(URL :NSURL(string: urlString)!)
        println(url!)
        webView!.loadRequest(urlRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = UIWebView()
        webView!.frame=self.view.frame
        webView!.backgroundColor=UIColor.grayColor()
        self.view.addSubview(webView!)
        loadDataSource()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
