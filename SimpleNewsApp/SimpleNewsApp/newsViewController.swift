//
//  newsViewController.swift
//  SimpleNewsApp
//
//  Created by Linus on 14-12-4.
//  Copyright (c) 2014年 Linus. All rights reserved.
//

import UIKit
import Social

class newsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var refreshControl = UIRefreshControl()
    var dataSource = []
    var imgQueue = NSOperationQueue()
    let hackerNewsApiUrl = "http://newsoflinus.sinaapp.com/api"
    
    @IBOutlet weak var newsTableView: UITableView!
    
    @IBOutlet var img: UIImageView!
    
    func refreshData() {
        loadDataSource()
        self.newsTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
        loadDataSource()
        
        refreshControl.attributedTitle = NSAttributedString(string: "松手刷新新闻")
        refreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        self.newsTableView.addSubview(refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataSource() {
        var url = hackerNewsApiUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var loadURL = NSURL(string: url!)
        println(url!)
        if loadURL != nil {
            println("ok")
        }else{
            println("empty")
        }
        
        let request: NSURLRequest = NSURLRequest(URL: loadURL!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
            (response, data, error) -> Void in
            
            if (error? != nil) {
                //Handle Error here
                println(error)
            }else{
                //Handle data in NSData type
                
                var returnString:NSString?
                returnString=NSString(data:data,encoding:NSUTF8StringEncoding)
                
                
                var err: NSError?
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &err) as NSArray
                
                if((err?) != nil) {
                    // If there is an error parsing JSON, print it to the console
                    println("JSON Error \(err!.localizedDescription)")
                }
                
                
                var currentNewsDataSource = NSMutableArray()
                for currentNews : AnyObject in jsonResult {
                    let newsItem = XHNewsItem()
                    newsItem.newsTitle = currentNews["title"] as NSString
                    newsItem.newsTime = currentNews["time"] as NSString
                    newsItem.newsImg = currentNews["img"] as NSString
                    newsItem.newsURL = currentNews["url"] as NSString
                    currentNewsDataSource.addObject(newsItem)
                    println(newsItem.newsTitle)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.dataSource = currentNewsDataSource
                        
                        self.newsTableView.reloadData()
                    })
                }
                
            }
        })
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let newsItem = dataSource[indexPath.row] as XHNewsItem
        cell.textLabel?.text = newsItem.newsTitle
        cell.imageView?.image = UIImage(named :"cell_photo")
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        let request = NSURLRequest(URL :NSURL(string: newsItem.newsImg)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: imgQueue, completionHandler: { response, data, error in
            let image = UIImage.init(data :data)
            
            dispatch_async(dispatch_get_main_queue(), {
                cell.imageView!.image = image
            })
        })
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var row = indexPath.row as Int
        var data = self.dataSource[row] as XHNewsItem
        //入栈
        var webview = WebViewController()
        webview.newsURL = data.newsURL
        webview.newsImg = data.newsImg
        self.presentViewController(webview, animated: true, completion: nil)
    }
    
}
