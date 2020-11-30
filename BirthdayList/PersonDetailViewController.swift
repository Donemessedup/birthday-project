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
    var totalNumTrips: Int = 0
    var friendIndex: Int = 0
    
    @IBOutlet var destLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayTrip()
    }
//displays the name, dates ,and image of the trip
    func displayTrip() {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if let friend = friendOptional, let personName = friend.name, let birthDate = friend.birthday {
            destLabel.text = "Name: " + personName

            if let bDate = birthDate as Date? {
                startDateLabel.text = "Start Date: \(dateFormatter.string(from: bDate))"
            }
        }

    }
}
