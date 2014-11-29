//
//  ViewController.swift
//  SimpleNewsApp
//
//  Created by Linus on 14-11-29.
//  Copyright (c) 2014年 Linus. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController {
    var dataSource = []
    var thumbQueue = NSOperationQueue()
    let hackerNewsApiUrl = "http://qingbin.sinaapp.com/api/lists?ntype=图片&pageNo=1&pagePer=10&list.htm"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataSource() {
        var url = hackerNewsApiUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var loadURL = NSURL(string: url!)
        if loadURL != nil {
            println("ok")
        }else{
            println("empty")
        }
        var request = NSURLRequest(URL: loadURL!)
        var loadDataSourceQueue = NSOperationQueue();
        NSURLConnection.sendAsynchronousRequest(request, queue: loadDataSourceQueue, completionHandler: { response, data, error in
            let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let newsDataSource = json["item"] as NSArray
            var currentNewsDataSource = NSMutableArray()
            for currentNews : AnyObject in newsDataSource {
                let newsItem = XHNewsItem()
                newsItem.newsTitle = currentNews["title"] as NSString
                newsItem.newsThumb = currentNews["thumb"] as NSString
                newsItem.newsID = currentNews["id"] as NSString
                currentNewsDataSource.addObject(newsItem)
                println(newsItem.newsTitle)
                dispatch_async(dispatch_get_main_queue(), {
                    self.dataSource = currentNewsDataSource
                    self.tableView.reloadData()
                })
            }
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let newsItem = dataSource[indexPath.row] as XHNewsItem
        cell.textLabel.text = newsItem.newsTitle
        cell.imageView.image = UIImage(named :"cell_photo_default_small")
        cell.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        let request = NSURLRequest(URL :NSURL(string: newsItem.newsThumb)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: thumbQueue, completionHandler: { response, data, error in
            let image = UIImage.init(data :data)
            dispatch_async(dispatch_get_main_queue(), {
                cell.imageView.image = image
            })
        })
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var row = indexPath.row as Int
        var data = self.dataSource[row] as XHNewsItem
        //入栈
        var webview = WebViewController()
        webview.detailID = data.newsID
        //取导航控制器,添加subView
        self.navigationController?.pushViewController(webview, animated: true)
    }
    
    
}

