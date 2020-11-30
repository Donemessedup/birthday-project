//
//  Friend+CoreDataProperties.swift
//  BirthdayList
//
//  Created by Walker, Charles Milton on 11/29/20.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var birthday: Date?
    @NSManaged public var interests: String?
    @NSManaged public var name: String?

}

extension Friend : Identifiable {

}
