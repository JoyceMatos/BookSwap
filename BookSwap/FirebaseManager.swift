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
// TODO: - Update string literals for refs
// TODO: - Handle errors
// TODO: - Conform to API protocol
// TODO: - Create enum that determines where to the database we are writing to
// TODO: - Fix multithreading with qos: userInitiated

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
                // TODO: - Handle error
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
                            // TODO: - Handle error
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
    
    // Add location to users info
    class func addUserLocation(_ uid: String, location: Int, completion: @escaping (Bool) -> Void) {
        let userLocation = ["zipCode": location]
        FirebaseManager.ref.child("users").child(uid).updateChildValues(userLocation) { (error, ref) in
            if error == nil {
                completion(true)
            } else {
                // Handle Error
                completion(false)
            }
        }
    }
    
    // MARK: Book Methods
    
    // TODO: - Add additional book properties (only add author & title for now
    // Adds book with book ID to Books DB
    class func add(_ book: Book, completion: @escaping (Bool) -> Void) {
        if let bookID = book.id {
            FirebaseManager.ref.child("books").updateChildValues([bookID: book.serialize()], withCompletionBlock: { (error, ref) in
                if error == nil {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                } else {
                    // TODO: - Handle error
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    print("Here is our error", error?.localizedDescription)
                }
                
            })
        }
    }
    
    // Adds book to library and create book ID
    class func add(_ book: Book, to libraryID: String, completion: @escaping (Bool) -> Void) {
        FirebaseManager.ref.child("libraries").child(libraryID).child("books").childByAutoId().setValue(true) { (error, ref) in
            if error == nil {
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                // Handle error
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
        
    }
    
    // NOTE: - Adds a new library to Library DB
    class func addLibrary(for userID: String, completion: @escaping (Bool) -> Void) {
        FirebaseManager.ref.child("libraries").childByAutoId().updateChildValues(["userID": userID]) { (error, ref) in
            if error == nil {
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                // Handle error
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    // NOTE: - Retrieves newly added libraryID from Library DB
    class func retreiveAddedLibrary(_ completion: @escaping (String) -> Void) {
        // TODO: - Carefully unwrap userID
        FirebaseManager.ref.child("libraries").observe(.childAdded, with: { (snapshot) in
            let libraryID = snapshot.key
            DispatchQueue.main.async {
                completion(libraryID)
            }
        })
    }
    
    // NOTE: - Updates user info with newly created library
    class func update(_ userID: String, with libraryID: String, completion: @escaping (Bool) -> Void) {
        FirebaseManager.ref.child("users").child(userID).child("library").setValue(libraryID) { (error, ref) in
            if error == nil {
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    // NOTE: - Updates user with book ID
    class func retrieveAddedBookID(from libraryID: String, completion: @escaping (String) -> Void) {
        FirebaseManager.ref.child("libraries").child(libraryID).child("books").observe(.childAdded, with: { (snapshot) in
            let bookID = snapshot.key
            DispatchQueue.main.async {
                completion(bookID)
            }
        })
    }
    
    // Gets all books from book ref
    class func retrieveAllBooks(_ completion: @escaping ([String: Any]) -> Void) {
        FirebaseManager.ref.child("books").observe(.value, with: { (snapshot) in
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
    
    // Get LibraryID
    class func getLibrary(for userID: String, completion: @escaping (String) -> Void) {
        FirebaseManager.ref.child("users").child(userID).child("library").observe(.value, with: { (snapshot) in
            let libraryID = snapshot.value
            DispatchQueue.main.async {
                completion(snapshot.value as! String)
            }
        })
    }
    
    // 2. Go to libraries and retrieve books from library
    class func retrieveBooks(from libraryID: String, completion: @escaping ([String: Any]) -> Void) {
        FirebaseManager.ref.child("libraries").child(libraryID).observe(.value, with: { (snapshot) in
            
            // GET Books
            print(snapshot.value)
            //   let book = snapshot.value
            
            // 3. Create book objects
            // 4. Return array of books
            
        })
    }
    
}

