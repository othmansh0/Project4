//
//  ListViewController.swift
//  Project4
//
//  Created by othman shahrouri on 8/9/21.
//

import UIKit

class ListViewController: UITableViewController {

    let websites = ["www.apple.com","www.google.com","youtube.com","microsoft.com","linkedin.com","facebook.com","amazon.com"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "Browser") as? WebViewController {
            vc.selectedWebsite = websites[indexPath.row]
            for website in websites {
                vc.websites2.append(website)
            }
            navigationController?.pushViewController(vc, animated: true)
            print("yay")
        }
        
    }
   
    
    

 

}
