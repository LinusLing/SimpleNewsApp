//
//  WebViewController.swift
//  SimpleNewsApp
//
//  Created by Linus on 14-11-29.
//  Copyright (c) 2014年 Linus. All rights reserved.
//

import UIKit
import Social

class WebViewController: UIViewController {
    var newsURL = NSString()
    var newsImg = NSString()

    var webView : UIWebView?
    var navi : UINavigationBar?
    var caption : UILabel?
    var button : UIButton?
    
    @IBOutlet var img: UIImageView!

    func loadSharingPic() -> UIImage {
        var image : UIImage?
        let url = NSURL(string: newsImg)
        let data : NSData = NSData(contentsOfURL: url!)!
        image = UIImage.init(data :data)
        return image!
    }
    
    func loadDataSource() {
        var urlString = newsURL
        var url = NSURL(string: urlString)
        var urlRequest = NSURLRequest(URL :NSURL(string: urlString)!)
        println(url!)
        self.webView!.loadRequest(urlRequest)
    }
    
    func didShared() {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeSinaWeibo) {
            var controller: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
            controller.setInitialText("最新的军事新闻，你值得拥有，关注我的GitHubhttps://github.com/kevin833752/SimpleNewsApp或者关注我的博客http://blogoflinus.sinaapp.com")
            controller.addImage(loadSharingPic())
            self.presentViewController(controller, animated: true,completion: nil)
        }
    }
//    @IBAction func shareDidTapped(sender: AnyObject) {
//        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeSinaWeibo) {
//            var controller: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
//            controller.setInitialText("最新的军事新闻，你值得拥有，尽在GitHub上https://github.com/kevin833752/SimpleNewsApp或者关注我的博客http://blogoflinus.sinaapp.com")
//            controller.addImage(self.img.image)
//            self.presentViewController(controller, animated: true,completion: nil)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navi = UINavigationBar()
        navi!.frame = CGRectMake(0, 0, self.view.frame.width, 80)
        navi!.backgroundColor = UIColor.grayColor()
        caption = UILabel()
        caption!.frame = CGRectMake(150, self.navi!.frame.height / 2 + 3, 80, 10)
        caption!.text = "军事新闻"
        caption!.font = UIFont.boldSystemFontOfSize(20)
        caption!.textAlignment = NSTextAlignment.Center
        caption!.hidden = false
        button = UIButton()
        button!.frame = CGRectMake(self.view.frame.width - 60, self.navi!.frame.height / 2 - 10, 40, 40)
        button!.titleColorForState(UIControlState.Highlighted)
        button!.titleLabel!.font = UIFont.boldSystemFontOfSize(18)
        button!.setTitle("分享", forState: UIControlState.Normal)
        button!.hidden = false
        button!.addTarget(self, action: "didShared", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(navi!)
        navi!.addSubview(caption!)
        navi!.addSubview(button!)
        webView = UIWebView()
        webView!.frame=CGRectMake(0, 80, self.view.frame.width, self.view.frame.height - 80)
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
