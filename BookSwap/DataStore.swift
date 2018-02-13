//
//  DataStore.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/23/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

// TODO: - Account for errors

class DataStore {
    static let shared = DataStore()
    var books: [Book] = []
    var usersBooks: [Book] = []
    
    private init() { }
    
    func getBooks(from service: FirebaseManager, completion: @escaping () -> Void) {
        books.removeAll()
        service.retrieveAllBooks { (storedBooks) in
            // TODO: - Maybe use higher order function indead
            for book in storedBooks {
                let bookDict = book.value as! [String: Any]
                let currentBook = Book(bookID: book.key, bookDict: bookDict)
                self.books.append(currentBook)
            }
            completion()
        }
    }
    
    func getUsersBooks(from service: FirebaseManager, for userID: String, completion: @escaping (Bool) -> Void) {
        usersBooks.removeAll()
        service.getLibrary(for: userID) { (libraryID) in
            service.retrieveBooks(from: libraryID, completion: { (bookIDs) in
                service.retrieveBooks(for: bookIDs, completion: { (allBooks) in
                    for book in allBooks {
                        let bookDict = book.value as! [String: Any]
                        let usersBook = Book(bookID: book.key, bookDict: bookDict)
                        self.usersBooks.append(usersBook)
                    }
                    completion(true)
                })
            })
        }  
    }
}
