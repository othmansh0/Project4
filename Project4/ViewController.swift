//
//  ViewController.swift
//  Project4
//
//  Created by othman shahrouri on 8/7/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton,spacer,refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
       
        
        
        
    }
    
    
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Canel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac,animated: true)
        
        
    }
    
    func openPage(action: UIAlertAction){
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle) else {return}
        
        webView.load(URLRequest(url: url))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

   
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)

        }
    }
    
// you are required to do something with decisionHandler closure. That might make sound an extremely complicated way of returning a value from a method
    
//  Having decisionHandler variable/function means you can show some user interface to the user "Do you really want to load this page?" and call the closure when you have an answer
    
//    you might call the decisionHandler closure straight away, or you might call it later on (perhaps after asking the user what they want to do) Swift considers it to be an escaping closure
   
//    @escaping acknowledging that the closure might be used later
    
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //host: website domain like apple.com
        
        //set url equal to the URL of the navigation
        let url = navigationAction.request.url
        
        if let host = url?.host {//if there is a host for this URL, pull it out
            for website in websites {
                if host.contains(website){ // check if host contains each safe website
                    decisionHandler(.allow)// allow loading
                    return
                }
                
            }
            
            let ac = UIAlertController(title: "Banned", message: "The link you're trying to visit is not safe", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac,animated: true)
            
        }

        decisionHandler(.cancel)
       
        
    }
    
    
    
    
    
}

