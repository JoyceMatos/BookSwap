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

final class SignUpViewModel: NSObject {
    
    var user: User?
    var userDetails: [String: Any]?
    
    init(_ user: User?, userDetails: [String: Any]) {
        self.user = user
        self.userDetails = userDetails
    }
    
    init(_ user: User?) {
        self.user = user
    }
    
    
    // MARK: - User Data Method
    
    func createUser(from details: [String: Any]) -> User? {
        let profilePhoto = details["profilePhoto"] as? URL
        let email = details["email"] as! String
        let firstName = details["firstName"] as! String
        let lastName = details["lastName"] as! String
        let location = details["locations"] as? String
        
        return User(id: nil, profilePhoto: profilePhoto, firstName: firstName, lastName: lastName, email: email, location: location)
    }
    
    // MARK: - Action Method
    
    func signUpTapped(by user: User, with password: String) {
        FirebaseManager.create(user, password: password) { (success, user) in
            if success {
                print(user?.id ?? "No user id")
                // Segue and pass this new user
            } else {
                print("Error signing up")
                // Handle this error
            }
        }
    }
    
    
    // MARK: - Segue Methods
    
    func handle(segue: UIStoryboardSegue, withSender sender: Any?) {
        if segue.identifier == SegueIdentifier.showZipCode {
            let destVC = segue.destination as! LocationViewController
            destVC.user = user
        }
    }
    
    
    
    
}
