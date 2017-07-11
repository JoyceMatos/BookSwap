//
//  FirebaseManager.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/11/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase


// TODO: - Refactor error & completions, ie: typealias
final class FirebaseManager {
    
    static var ref: DatabaseReference!
    
    // Create New User
    class func create(_ newUser: User?, email: String, password: String, completion: @escaping (Bool, User?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if var newUser = newUser, let user = user {
                ref.child("users").child(user.uid).setValue(newUser.serialize(), withCompletionBlock: { error, ref in
                    newUser.id = user.uid
                    guard error == nil else { completion(false, nil); return }
                    completion(true, newUser)
                    }
                )}
            } else {
                completion(false, nil)
            }
        })
    }
    
    
    
    
}
