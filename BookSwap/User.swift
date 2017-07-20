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
    var location: Int? // Might be zipcode
    
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

extension User {
    
    init(_ details: [String: Any]) {
        self.email = details["email"] as! String
        self.firstName = details["firstName"] as! String
        self.lastName = details["lastName"] as! String
    }
    
}
