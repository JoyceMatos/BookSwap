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
// TODO: - Check string literals
// TODO: - Handle errors
// TODO: - Fix multithreading with qos: userInitiated

final class FirebaseManager: NetworkingService {
    static var ref = Database.database().reference()
}

// MARK: - Auth Methods

extension FirebaseManager {
        
    // NOTE: - Note in use yet (will be used once create method is refactors)
    func authenticate(_ newUser: User?, password: String, completion: @escaping (Bool, User?) -> Void) {
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
}

// MARK: - Users Methods

extension FirebaseManager {
    
    // TODO: - Refactor and use auth method above!!
    func create(_ newUser: User?, password: String, completion: @escaping (Bool, User?) -> Void) {
        guard var newUser = newUser else {
            print("no user") // TODO: - Handle Error
            return
        }
        
        Auth.auth().createUser(withEmail: newUser.email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    FirebaseManager.ref.child(Ref.users).child(user.uid).setValue(newUser.serialize(), withCompletionBlock: { (error, ref) in
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
    
    func getLibrary(for userID: String, completion: @escaping (String) -> Void) {
        FirebaseManager.ref.child(Ref.users).child(userID).child(Ref.library).observe(.value, with: { (snapshot) in
            let libraryID = snapshot.value
            DispatchQueue.main.async {
                completion(snapshot.value as! String)
            }
        })
    }
    
    // NOTE: - Updates user info with newly created library
    func update(_ userID: String, with libraryID: String, completion: @escaping (Bool) -> Void) {
        FirebaseManager.ref.child(Ref.users).child(userID).child(Ref.library).setValue(libraryID) { (error, ref) in
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
    
    // Add location to users info
    func addUserLocation(_ uid: String, location: Int, completion: @escaping (Bool) -> Void) {
        let userLocation = ["zipCode": location]
        FirebaseManager.ref.child(Ref.users).child(uid).updateChildValues(userLocation) { (error, ref) in
            if error == nil {
                completion(true)
            } else {
                // Handle Error
                completion(false)
            }
        }
    }
}

// MARK: - Libraries Methods

extension FirebaseManager {
    
    func retrieveBooks(from libraryID: String, completion: @escaping ([String]) -> Void) {
        FirebaseManager.ref.child(Ref.libraries).child(libraryID).child(Ref.books).observe(.value, with: { (snapshot) in
            var bookIDs = [String]()
            let books = snapshot.value as? [String: Any]
            if let books = books {
                for book in books {
                    bookIDs.append(book.key)
                }
            }
            completion(bookIDs)
        })
    }
    
    // NOTE: - Updates user with book ID
    func retrieveAddedBookID(from libraryID: String, completion: @escaping (String) -> Void) {
        FirebaseManager.ref.child(Ref.libraries).child(libraryID).child(Ref.books).observe(.childAdded, with: { (snapshot) in
            let bookID = snapshot.key
            DispatchQueue.main.async {
                completion(bookID)
            }
        })
    }
    
    // NOTE: - Retrieves newly added libraryID from Library DB
    func retreiveAddedLibrary(_ completion: @escaping (String) -> Void) {
        // TODO: - Carefully unwrap userID
        FirebaseManager.ref.child(Ref.libraries).observe(.childAdded, with: { (snapshot) in
            let libraryID = snapshot.key
            DispatchQueue.main.async {
                completion(libraryID)
            }
        })
    }
    
    // NOTE: - Adds a new library to Library DB
    func addLibrary(for userID: String, completion: @escaping (Bool) -> Void) {
        FirebaseManager.ref.child(Ref.libraries).childByAutoId().updateChildValues(["userID": userID]) { (error, ref) in
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
    
    func add(_ book: Book, to libraryID: String, completion: @escaping (Bool) -> Void) {
        guard let bookID = book.id else {
            print("Nope no book ID")
            completion(false)
            return
        }
        
        FirebaseManager.ref.child(Ref.libraries).child(libraryID).child(Ref.books).updateChildValues([bookID: true]) { (error, ref) in
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
}

// MARK: - Books Methods
extension FirebaseManager {
    
    func retrieveBooks(for bookIDs: [String], completion: @escaping ([String: Any]) -> Void) {
        FirebaseManager.ref.child(Ref.books).observe(.value, with: { (snapshot) in
            let bookDictionary = snapshot.value as? [String: Any]
            var books = [String: Any]()
            if let bookDictionary = bookDictionary {
                for book in bookDictionary {
                    if bookIDs.contains(book.key) {
                        books[book.key] = book.value
                    }
                }
            }
            completion(books)
        })
    }
    
    // Gets all books from book ref
    func retrieveAllBooks(_ completion: @escaping ([String: Any]) -> Void) {
        FirebaseManager.ref.child(Ref.books).observe(.value, with: { (snapshot) in
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
    
    func create(_ book: Book, completion: @escaping (String?) -> Void) {
        guard let userID = book.userID, let libraryID = book.libraryID else {
            completion(nil)
            return
        }
        
        let bookDict = ["title": book.title, "author": book.author, "userID": book.userID, "libraryID": book.libraryID]
        
        FirebaseManager.ref.child(Ref.books).childByAutoId().updateChildValues(bookDict) { (error, ref) in
            if error == nil {
                DispatchQueue.main.async {
                    completion(ref.key)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    // TODO: - Add additional book properties (only add author & title for now
    // Adds book with book ID to Books DB
    func add(_ book: Book, completion: @escaping (Bool) -> Void) {
        if let bookID = book.id {
            FirebaseManager.ref.child(Ref.books).updateChildValues([bookID: book.serialize()], withCompletionBlock: { (error, ref) in
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
}
