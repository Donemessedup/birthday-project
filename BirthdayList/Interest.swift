//
//  Interest.swift
//  BirthdayList
//
//  Created by Miller, Aaron Paul on 11/29/20.
//

import Foundation

class Interest {
//    var name: String
//    var webLink: URL
    var interests: [String] = []
//
//    init(name: String, webLink: URL) {
//        self.name = name
//        self.webLink = webLink
//    }
//grab each interest from the interests string and attach to array. Interests seperated by spaces
    init(interestsString: String) {
        self.interests = interestsString.components(separatedBy: " ")
    }
}
