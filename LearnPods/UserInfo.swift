//
//  UserInfo.swift
//  LearnPods
//
//  Created by Yao Lu on 2017-07-10.
//  Copyright © 2017 Yao Lu. All rights reserved.
//

import Foundation
import ObjectMapper

class UserInfo: Mappable {
    var displayName: String?
    var signature: String?
    var birthday: String?
    var mainImage: String?

    required init?(displayName: String,signature: String, birthday:String,mainImage:String) {
        self.displayName = displayName
        self.signature = signature
        self.birthday = birthday
        self.mainImage = mainImage
     
    }
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        displayName    <- map["displayName"]
        signature      <- map["signature"]
        birthday       <- map["birthday"]
        mainImage      <- map["mainImage"]
    }
}


