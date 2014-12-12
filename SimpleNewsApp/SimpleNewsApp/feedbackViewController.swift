//
//  feedbackViewController.swift
//  SimpleNewsApp
//
//  Created by Linus on 14-12-12.
//  Copyright (c) 2014年 Linus. All rights reserved.
//

import UIKit

class feedbackViewController: UIViewController {
    var rightBarButtonItem: UIBarButtonItem?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var suggestionText: UITextView!
    @IBOutlet weak var emailText: UITextField!
    
    func didSent() {
        let te = suggestionText.text
        let email = emailText.text
        if te == "" || email == "" {
            let alert = UIAlertView(title: "出错", message: "请填写完整的反馈信息", delegate: self, cancelButtonTitle: "知道了")
            alert.show()
        }else {
            let alert = UIAlertView(title: "通知", message: "我们已经收到您的反馈信息了，我们会给您的邮箱进行回复的。", delegate: self, cancelButtonTitle: "好的")
            alert.show()
            println("\(te)\n\(email)")
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        rightBarButtonItem = UIBarButtonItem(image: nil, landscapeImagePhone: nil, style: UIBarButtonItemStyle.Plain, target: self, action: "didSent")
        rightBarButtonItem!.title = "发送"
        self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: true)
        textView.layer.borderColor = UIColor.grayColor().CGColor
        textView.layer.borderWidth = 1

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
