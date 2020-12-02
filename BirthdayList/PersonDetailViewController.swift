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

class PersonDetailViewController: UIViewController {
    let dateFormatter = DateFormatter()
    var friendOptional: Friend? = nil
    
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
        
        if let friend = friendOptional, let personName = friend.name, let birthDate = friend.birthday, let tempString = friend.interests {
            destLabel.text = "Name: " + personName
            let interests = tempString.components(separatedBy: "* ")
            print(interests.count)
            print("\(interests)")
            interest1Button.setTitle(interests[0], for: .normal)
            self.interest2Button.isHidden = true
            self.interest3Button.isHidden = true
            if interests.count == 2 {
                interest2Button.setTitle(interests[1], for: .normal)
                self.interest2Button.isHidden = false
                print("succses")
            }
            if interests.count == 3 {
                interest2Button.setTitle(interests[1], for: .normal)
                interest3Button.setTitle(interests[2], for: .normal)
                self.interest2Button.isHidden = false
                self.interest3Button.isHidden = false
                print("sdfsa")
            }
           
            if let bDate = birthDate as Date? {
                startDateLabel.text = "Start Date: \(dateFormatter.string(from: bDate))"
            }
        }

    }
}
