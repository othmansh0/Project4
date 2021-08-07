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
   
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.apple.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [spacer,refresh]
        navigationController?.isToolbarHidden = false
        
        
        
        
        
    }
    
    
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.con", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com" , style: .default, handler: openPage))
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

    
    
}

