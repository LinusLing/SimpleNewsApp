//
//  ViewController.swift
//  SimpleNewsApp
//
//  Created by Linus on 14-11-29.
//  Copyright (c) 2014年 Linus. All rights reserved.
//

import UIKit
import Social

var filteredNews: [XHNewsItem] = []

class RootTableViewController: UITableViewController, UISearchDisplayDelegate {
    var dataSource:[XHNewsItem] = []
    var imgQueue = NSOperationQueue()
    let hackerNewsApiUrl = "http://newsoflinus.sinaapp.com/api"
    
    @IBOutlet var newsTableView: UITableView!
    @IBOutlet var img: UIImageView!
    func loadSharingImage() {
        
        let newsItem = dataSource[0] as XHNewsItem
        let request = NSURLRequest(URL :NSURL(string: newsItem.newsImg)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { response, data, error in
            let image = UIImage.init(data :data)
            dispatch_async(dispatch_get_main_queue(), {
                self.img.image = image
            })
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        filteredNews = dataSource.filter(
            {$0.newsTitle.rangeOfString(searchString).length != 0}
        )
        return true
    }
    
    // 刷新数据
    func refreshData() {
        
        println("refreshing")
        loadDataSource()
        self.newsTableView.reloadData()
        self.refreshControl!.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadDataSource()
        
        //添加刷新
        self.refreshControl = UIRefreshControl()
        refreshControl!.frame.size.height = 10
        refreshControl!.attributedTitle = NSAttributedString(string: "松手刷新新闻")
        refreshControl!.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        self.newsTableView.addSubview(refreshControl!)
        
        //隐藏searchBar
        var contentOffset = tableView.contentOffset
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        tableView.contentOffset = contentOffset
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
            println("loadURL ok")
        }else{
            println("loadURL empty")
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
                returnString = NSString(data:data,encoding:NSUTF8StringEncoding)
                
                
                var err: NSError?
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &err) as NSArray
                
                if((err?) != nil) {
                    // If there is an error parsing JSON, print it to the console
                    println("JSON Error \(err!.localizedDescription)")
                }
                
                var currentNewsDataSource: [XHNewsItem] = []
                for currentNews : AnyObject in jsonResult {
                    let newsItem = XHNewsItem()
                    newsItem.newsTitle = currentNews["title"] as NSString
                    newsItem.newsTime = currentNews["time"] as NSString
                    //
                    if(currentNews["img"] as NSString == " "){
                        continue
                    }else{
                        newsItem.newsImg = currentNews["img"] as NSString
                    }
                    newsItem.newsURL = currentNews["url"] as NSString
                    currentNewsDataSource.append(newsItem)
                    //                    println(newsItem.newsTitle)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.dataSource = currentNewsDataSource
                        self.tableView.reloadData()
                    })
                }
            }
        })
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController?.searchResultsTableView {
            return filteredNews.count
        }else {
            return dataSource.count
        }
        
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    //    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 0
    //    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        var newsItem: XHNewsItem
        if tableView == searchDisplayController?.searchResultsTableView {
            newsItem = filteredNews[indexPath.row]
        }else {
            newsItem = dataSource[indexPath.row]
        }
        
        cell.textLabel?.text = newsItem.newsTitle
        //println(newsItem.newsImg)
        //if((newsItem.newsImg.isEqualToString("")) && (newsItem.newsImg.isEqual(nil))){
        cell.imageView?.image = UIImage(named :"cell_photo")
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        let request = NSURLRequest(URL :NSURL(string: newsItem.newsImg)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: imgQueue, completionHandler: { response, data, error in
            let image = UIImage.init(data :data)
            
            dispatch_async(dispatch_get_main_queue(), {
                cell.imageView!.image = image
            })
        })
        //        }else{
        //
        //        }
        
        return cell
    }
    
    //    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return 80
    //    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var row = indexPath.row as Int
        var data = self.dataSource[row] as XHNewsItem
        //入栈
        var webview = WebViewController()
        webview.newsURL = data.newsURL
        webview.newsImg = data.newsImg
        webview.newsTitle = data.newsTitle
        //取导航控制器,添加subView
        self.navigationController?.pushViewController(webview, animated: true)
    }
    
    
}

