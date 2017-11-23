//
//  USERS+CoreDataProperties.swift
//  LearnPods
//
//  Created by Deepesh Mehta on 2017-11-22.
//  Copyright © 2017 Yao Lu. All rights reserved.
//
//

import Foundation
import CoreData


extension USERS {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<USERS> {
        return NSFetchRequest<USERS>(entityName: "USERS")
    }

    @NSManaged public var birthday: String?
    @NSManaged public var displayName: String?
    @NSManaged public var id: String?
    @NSManaged public var mainImage: String?
    @NSManaged public var signature: String?

}
