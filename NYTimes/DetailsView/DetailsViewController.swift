//
//  DetailsViewController.swift
//  NYTimes
//
//  Created by Damu on 15/11/18.
//  Copyright © 2018 Damu. All rights reserved.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController {


    var articalTitle : String!
    var descriptionurl : String!

    @IBOutlet var descriptionView: WKWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        basicIntilaizations()
        // Do any additional setup after loading the view.
    }
    
   private func basicIntilaizations()
    {
        self.title = articalTitle
        descriptionView.navigationDelegate = self
        if let url = URL(string: descriptionurl)
        {
            let request = URLRequest(url: url)
            activityIndicator.startAnimating()
            descriptionView.load(request)
        }
     }
}

extension DetailsViewController : WKNavigationDelegate
{
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("fail to load")
        activityIndicator.stopAnimating()

    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start to load")
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        activityIndicator.stopAnimating()


    }
   
}
