//
//  WebViewController.swift
//  BirthdayList
//
//  Created by Walker, Charles Milton on 11/30/20.
//

import UIKit
import WebKit
import CoreData

class WebViewController: UIViewController {
    
    let webView = WKWebView()
    var urlVar = ""
    var friendOptional: Friend? = nil
    
//have to pass the index of the interest that is selected from friend.interests 
    var interestNum = 0
    
    override func loadView() {
        self.view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let friend = friendOptional {
//            let interests = Interest(interestsString: friend.interests ?? "nothing")
            let interests = friend.interests!.components(separatedBy: "* ")
            urlVar = interests[interestNum]
            if let url = URL(string: "http://www.amazon.com/s?url=search-alias%3Daps&field-keywords="+urlVar) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
