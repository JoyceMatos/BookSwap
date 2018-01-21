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
    var location: Int?
    var libraryID: String?
    
    func serialize() -> [String: Any] {
        let userInfo: [String: Any] = [
            "firstName" : firstName,
            "lastName" : lastName,
            "email" : email
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
