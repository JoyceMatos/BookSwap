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


// TODO: - Refactor
// TODO: - Handle errors
// TODO: - Create API protocols 
// TODO: - Create enum that determines where to the database we are writing to
// ie:     // class func add(to database: DatabaseType)


final class FirebaseManager {
    
    static var ref = Database.database().reference()
    
    // Create New User
    
    // NOTE: - Note in use yet (will be used once create method is refactors)
    class func authenticate(_ newUser: User?, password: String, completion: @escaping (Bool, User?) -> Void) {
        guard var newUser = newUser else {
            print("no user") // TODO: - Handle Error
            return
        }
        
        Auth.auth().createUser(withEmail: newUser.email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    newUser.id = user.uid
                    completion(true, newUser)
                }
            } else {
                completion(false, nil)
            }
        })
    }
    
    
    class func create(_ newUser: User?, password: String, completion: @escaping (Bool, User?) -> Void) {
        guard var newUser = newUser else {
            print("no user") // TODO: - Handle Error
            return
        }
        
        Auth.auth().createUser(withEmail: newUser.email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    ref.child("users").child(user.uid).setValue(newUser.serialize(), withCompletionBlock: { (error, ref) in
                        newUser.id = user.uid
                        guard error == nil else {
                            completion(false, nil)
                            return
                        }
                        completion(true, newUser)
                    }
                    )}
            } else {
                print(error?.localizedDescription)
                completion(false, nil)
            }
        })
    }
    
    // Add location
    
    class func addUserLocation(_ uid: String, location: Int, completion: @escaping (Bool) -> Void) {
        let userLocation = ["zipCode": location]
        FirebaseManager.ref.child("users").child(uid).updateChildValues(userLocation) { (error, ref) in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    // Add Book 
    // TODO: - Only adds the basics for now
    // TODO: - Refactor!
    class func add(_ book: Book, user: User, completion: @escaping (Bool) -> Void) {
        
        // Add book to book branch
        // Add book to user
        
        FirebaseManager.ref.child("books").childByAutoId().updateChildValues(book.serialize()) { (error, ref) in
            if error == nil {
                
                // 1. Retrieve book key
                FirebaseManager.ref.child("books").observe(.childAdded, with: { (snapshot) in
                    
                    let bookID = snapshot.key
                    
                    // 2. Update user info
                    FirebaseManager.ref.child("users").child(user.id!).updateChildValues(["books": [bookID]], withCompletionBlock: { (error, ref) in
                        if error == nil {
                            print("yay we updated book for user")
                        } else {
                            print("uh oh, didn't update user")
                        }
                    })
                })
                
                // 1. Retrieve the book's key
                // 2. Update user info with book key
                completion(true)
            } else {
                print("error adding book")
                completion(false)
                // Handle this case
            }
        }
    }
}

