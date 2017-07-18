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
    
//    var id: Dynamic<String?>
//    var firstName: Dynamic<String>
//    var lastName: Dynamic<String>
//    var email: Dynamic<String>
//    var profilePhoto: Dynamic<URL?>
//    var location: Dynamic<String?>
    
    init(userDetails: [String: Any]) {
        self.userDetails = userDetails
    }
    
//    init(_ firstName: String, lastName: String, email: String) {
//        self.firstName = Dynamic(firstName)
//        self.lastName = Dynamic(lastName)
//        self.email = Dynamic(email)
//    }
    
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
    
    func signUpTapped(by user: User, with password: String, completion: @escaping (Bool) -> Void) {
        FirebaseManager.create(user, password: password) { (success, user) in
            if success {
                print(user?.id ?? "No user id")
                completion(true)
                // Segue and pass this new user
            } else {
                print("Error signing up")
                completion(false)
                // Handle this error
            }
        }
    }
    
    
    // MARK: - Segue Methods
    
    func handle(segue: UIStoryboardSegue, withSender sender: Any?) {
        if segue.identifier == SegueIdentifier.showLocation {
            let destVC = segue.destination as! LocationViewController
            destVC.user = user
        }
    }
    
    
    
    
}
