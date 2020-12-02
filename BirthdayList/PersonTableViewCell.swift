//
//  TripTableViewCell.swift
//  Pa7
//  This class creates the custom table view cell.
//  CPSC 315-01, Fall 2020
//  No sources to cite
//  Created by Walker, Charles Milton on 11/5/20.
//  Copyright © 2020 Walker, Charles Milton. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    let dateFormatter = DateFormatter()
    @IBOutlet var destLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func update(with friend: Friend) {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        destLabel.text = friend.name
        if let birthDate = friend.birthday as Date? {
            dateLabel.text = "\(dateFormatter.string(from: birthDate))"
        }


    }
}
