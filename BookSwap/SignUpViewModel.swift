//
//  SignUpViewModel.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/14/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UIKit

// TODO: - Make sure if NSObject is necessary

struct SignUpViewModel {
    
    var user: User?
    var userDetails: [String: Any]
    
    init(userDetails: [String: Any]) {
        self.userDetails = userDetails
    }

    // MARK: - User Method
    
    func createUser(from details: [String: Any]) -> User? {
        let profilePhoto = details["profilePhoto"] as? URL
        let email = details["email"] as! String
        let firstName = details["firstName"] as! String
        let lastName = details["lastName"] as! String
        let location = details["locations"] as? Int
        
        return User(id: nil, profilePhoto: profilePhoto, firstName: firstName, lastName: lastName, email: email, location: location)
    }
    
    // MARK: - Action Method
    
    func signUpTapped(by user: User, with password: String, completion: @escaping (Bool, User?) -> Void) {
        FirebaseManager.create(user, password: password) { (success, user) in
            if success {
                print(user?.id ?? "No user id")
                completion(true, user)
                // Segue and pass this new user
            } else {
                print("Error signing up")
                completion(false, nil)
                // Handle this error
            }
        }
    }
    
}
