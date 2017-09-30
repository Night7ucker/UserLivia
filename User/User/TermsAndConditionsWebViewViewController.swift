//
//  TermsAndConditionsWebViewViewController.swift
//  User
//
//  Created by User on 9/26/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import WebKit

class TermsAndConditionsWebViewViewController: RootViewController, WKNavigationDelegate {

    var webView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Terms and Conditions")
        
        let myBlog = "https://test.liviaapp.com/api/page/1?language=ru&country=by"
        let url = NSURL(string: myBlog)
        let request = NSURLRequest(url: url! as URL)
        
        webView = WKWebView(frame: self.view.frame)
        webView.navigationDelegate = self
        webView.load(request as URLRequest)
        self.view.addSubview(webView)
        self.view.sendSubview(toBack: webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
