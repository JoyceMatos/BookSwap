//
//  LoginViewModel.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/11/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

final class LoginViewModel {
    
    
    func createUser(from details: [String: Any]) -> User? {
        let profilePhoto = details["profilePhoto"] as? URL
        let email = details["email"] as! String
        let firstName = details["firstName"] as! String
        let lastName = details["lastName"] as! String
        let location = details["locations"] as? String
        
        return User(id: nil, profilePhoto: profilePhoto, firstName: firstName, lastName: lastName, email: email, location: location)
    }
    
    func createAccount(for currentUser: User?) {
        
     //   FirebaseManager.create(<#T##newUser: User?##User?#>, email: <#T##String#>, password: <#T##String#>, completion: <#T##(Bool, User?) -> Void#>)
        
    }
    
    
    
    
}
