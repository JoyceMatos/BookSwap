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
// TODO: - Create API protocols and have this manager conform to it
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
    
    // MARK: Book Methods
    
    // TODO: - Add additional book properties (only add author & title for now
    // NOTE: - Adds book to book node
    class func add(_ book: Book, completion: @escaping (Bool) -> Void) {
        FirebaseManager.ref.child("books").childByAutoId().updateChildValues(book.serialize()) { (error, ref) in
            if error == nil {
                completion(true)
            } else {
                completion(false)
                // Handle this case
            }
        }
    }
    
    // NOTE: - Retrieves added book ID
    class func retreiveAddedBook(_ completion: @escaping (String) -> Void) {
        FirebaseManager.ref.child("books").observe(.childAdded, with: { (snapshot) in
            let bookID = snapshot.key
            completion(bookID)
        })

    }
    
    // NOTE: - Updates user with book ID
    class func updateUsersBooks(_ userID: String, bookID: String, completion: @escaping (Bool) -> Void) {
        FirebaseManager.ref.child("users").child(userID).updateChildValues(["books": [bookID]], withCompletionBlock: { (error, ref) in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    class func retrieveAllBooks(_ completion: @escaping ([String: Any]) -> Void) {
        print("In firebase method")

        FirebaseManager.ref.child("books").observe(.value, with: { (snapshot) in
                print("In firebase queue")


            var dictionary = [String: Any]()
            let books = snapshot.value as? [String: Any]
            
            if let books = books {
            for book in books {
                let key = book.key
                let value = book.value as? [String: Any]
                dictionary[key] = value
                }
                DispatchQueue.main.async {

                    completion(dictionary)
                }
            
            }

        })
    }
}

