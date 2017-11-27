//
//  UserDetailsMap.swift
//  LearnPods
//
//  Created by Deepesh Mehta on 2017-11-21.
//  Copyright © 2017 Yao Lu. All rights reserved.
//

import Foundation
import ObjectMapper

class UserDetailsMap: Mappable {
    var id: String?
    var main: [String: Any]!
    var admin: [String: Any]!
    var statistics: [String: Any]!
    var image: [[String: Any]]!
    var description: [[String: Any]]!
    var basic: [[String: Any]]!
    var match: [[String: Any]]!
    var attitude: [[String: Any]]!
    var gift: [[String: Any]]!
    var tag: [[String: Any]]!
//    var option: [Any]!
    
    
    required init?(map: Map) {
        
    }
    
    required init?(id: String, main: [String: Any], admin: [String: Any], statistics: [String: Any], image: [[String: Any]], description: [[String: Any]], basic: [[String: Any]], match: [[String: Any]], attitude: [[String: Any]], gift: [[String: Any]], tag: [[String: Any]]){
        self.id = id;
        self.main = main;
        self.admin = admin
        self.statistics = statistics
        self.image = image
        self.description = description
        self.basic = basic
        self.match = match
        self.attitude = attitude
        self.gift = gift
        self.tag = tag
        
    }
    
    subscript(key: String) -> AnyObject{
        get{
            switch key {
            case "id": return self.id as AnyObject
            case "main": return (self.main as AnyObject)
            case "admin": return (self.admin as AnyObject)
            case "statistics": return (self.statistics as AnyObject)
            case "image": return (self.image as AnyObject)
            case "description": return (self.description as AnyObject)
            case "basic": return (self.basic as AnyObject)
            case "match": return (self.match as AnyObject)
            case "attitude": return (self.attitude as AnyObject)
            case "gift": return (self.gift as AnyObject)
            case "tag": return (self.tag as AnyObject)
            default: return (key as AnyObject)
            }
        }
        set{
            print("subscript called for \(key)")
            switch key {
            case "id": self.id = newValue as? String
            case "main": self.main = newValue as? [String: Any]
            case "admin": self.admin = newValue  as? [String: Any]
            case "statistics": self.statistics = newValue  as! [String: Any]
            case "image": self.image = newValue as? [[String: Any]]
            case "description": self.description = newValue as! [[String: Any]]
            case "basic": self.basic = newValue as? [[String: Any]]
            case "match": self.match = newValue as? [[String: Any]]
            case "attitude": self.attitude = newValue as? [[String: Any]]
            case "gift": self.gift = newValue as? [[String: Any]]
            case "tag": self.tag = newValue as? [[String: Any]]
            default: print("invalid key\(key)")
            }
        }
    }
    
    
    
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        admin <- map["admin"]
        statistics <- map["statistics"]
        image <- map["image"]
        description <- map["description"]
        basic <- map["basic"]
        match <- map["match"]
        attitude <- map["attitude"]
        gift <- map["gift"]
        tag <- map["tag"]
//        option <- map["option"]
        
    }
}


