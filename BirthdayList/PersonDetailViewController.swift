//
//  TripDetailViewController.swift
//  Pa7
//  This class is the view controller for displaying the details of the trip. 
//  CPSC 315-01, Fall 2020
//  No sources to cite
//  Created by Walker, Charles Milton on 11/5/20.
//  Copyright © 2020 Walker, Charles Milton. All rights reserved.
//

import UIKit
import WebKit

class PersonDetailViewController: UIViewController, WKNavigationDelegate {
    let dateFormatter = DateFormatter()
    var friendOptional: Friend? = nil
    let webView = WKWebView()
    var urlVar = ""
    
    @IBOutlet var destLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var interest1Button: UIButton!
    @IBOutlet var interest2Button: UIButton!
    @IBOutlet var interest3Button: UIButton!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayFriend()
    }
//displays the name, dates ,and image of the trip
    func displayFriend() {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        if let friend = friendOptional, let birthDate = friend.birthday, let tempString = friend.interests {
            destLabel.text = "Name: " + friend.name
            let interests = tempString.components(separatedBy: "* ")
            print(interests.count)
            print("\(interests)")
            interest1Button.setTitle(interests[0], for: .normal)
            self.interest2Button.isHidden = true
            self.interest3Button.isHidden = true
            if interests.count == 2 {
                interest2Button.setTitle(interests[1], for: .normal)
                self.interest2Button.isHidden = false
            }
            if interests.count == 3 {
                interest2Button.setTitle(interests[1], for: .normal)
                interest3Button.setTitle(interests[2], for: .normal)
                self.interest2Button.isHidden = false
                self.interest3Button.isHidden = false
            }
           
            if let bDate = birthDate as Date? {
                startDateLabel.text = "Birthdate: \(dateFormatter.string(from: bDate))"
            }
        }

    }

    @IBAction func prevBtn(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @IBAction func nextBtn(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func openWeb(sender: UIButton) {
        self.view = webView
        
        webView.navigationDelegate = self
        
        if let friend = friendOptional, let tempString = friend.interests {

            urlVar = sender.currentTitle!
            var urlString = "http://www.amazon.com/s?url=search-alias%3Daps&field-keywords=" + urlVar
            urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if let url = URL(string: urlString ) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
    
    
    
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
//    {
//        print(#function)
//    }
//
//    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!)
//    {
//        print(#function)
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
//    {
//        print(#function)
//    }
//
//    func webView(_ webView: WKWebView, didFailwithError navigation: WKNavigation!)
//    {
//        print(#function)
//    }
//
//    func webView(_ webView: WKWebView, didFailProvisionalNavigationwithError navigation: WKNavigation!)
//    {
//        print(#function)
//    }
}
