//
//  UserData+CoreDataProperties.swift
//  LearnPods
//
//  Created by Deepesh Mehta on 2017-11-22.
//  Copyright © 2017 Yao Lu. All rights reserved.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var data: NSData?
    @NSManaged public var title: String?
    @NSManaged public var userid: String?

}
