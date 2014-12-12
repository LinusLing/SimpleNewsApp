//
//  settingViewController.swift
//  SimpleNewsApp
//
//  Created by Linus on 14-12-4.
//  Copyright (c) 2014年 Linus. All rights reserved.
//

import UIKit

class settingViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    var settingList = ["意见反馈","我要评分","关于我们"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var row = indexPath.row as Int
        var data = self.settingList[row] as NSString
        println("\(row) \(data)")
        if data == "意见反馈" {
            let FeedBackViewControllerIdentifier = "feedback"
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let feedbackView: feedbackViewController = storyboard.instantiateViewControllerWithIdentifier(FeedBackViewControllerIdentifier) as feedbackViewController
            self.navigationController?.pushViewController(feedbackView, animated: true)
        }else if data == "我要评分" {
            
        }else if data == "关于我们" {
            let AboutViewControllerIdentifier = "about"
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let aboutView: aboutViewController = storyboard.instantiateViewControllerWithIdentifier(AboutViewControllerIdentifier) as aboutViewController
            self.navigationController?.pushViewController(aboutView, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedback", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.settingList[indexPath.row]
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender?.isKindOfClass(UITableViewCell) != nil) {
            var row = settingTableView.indexPathForSelectedRow()?.row
            
//            if row == 0 {
            if segue.identifier == "feedback" {
                println("feedback")
                var vc = segue.destinationViewController as feedbackViewController
            }
//            else if row == 3 {
            else if segue.identifier == "about"{
                println("about")
                var vc : aboutViewController = segue.destinationViewController as aboutViewController
            }
            
        }
    }
    
}
