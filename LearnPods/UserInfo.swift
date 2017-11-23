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
    var id: String?
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
    
    required init?(user: USERS){
        self.displayName = user.displayName
        self.signature = user.signature
        self.birthday = user.birthday
        self.mainImage = user.mainImage
        self.id = user.id
    }
    
    required init?(displayName: String,signature: String, birthday:String,mainImage:String,id:String) {
        self.displayName = displayName
        self.signature = signature
        self.birthday = birthday
        self.mainImage = mainImage
        self.id = id
        
    }
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        displayName <- map["displayName"]
        signature <- map["signature"]
        birthday <- map["birthday"]
        mainImage <- map["mainImage"]
    }
}


