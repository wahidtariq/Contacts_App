//
//  ContactDetail+CoreDataProperties.swift
//  Contacts.
//
//  Created by wahid tariq on 16/08/21.
//
//

import Foundation
import CoreData


extension ContactDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactDetail> {
        return NSFetchRequest<ContactDetail>(entityName: "ContactDetail")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

}

extension ContactDetail : Identifiable {

}
