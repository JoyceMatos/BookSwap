//
//  User.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/11/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

struct User {
    
    var id: String?
    var profilePhoto: URL?
    var firstName: String
    var lastName: String
    var email: String
    var location: String? // Might be zipcode
    
//    init(_ details: [String: Any]) {
//        let id
//        let profilePhoto = details["profilePhoto"] as? URL
//        let email = details["email"] as! String
//        let firstName = details["firstName"] as! String
//        let lastName = details["lastName"] as! String
//        let location = details["locations"] as? String
//    }
    
    func serialize() -> [String: Any] {
        let userInfo: [String: Any] = [
           // "profilePhoto" : profilePhoto,
            "firstName" : firstName,
            "lastName" : lastName,
            "email" : email
          //  "location" : location
            ]
        
        return userInfo
    }
    
    
    
}
