//
//  DataStore.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/23/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

final class DataStore {
    
    static let shared = DataStore()
    var books: [Book] = []
    
    private init() { }
    
    func getBooks(completion: @escaping () -> Void) {
        books.removeAll()
        FirebaseManager.retrieveAllBooks { (storedBooks) in
            // TODO: - Maybe use higher order function indead
            for book in storedBooks {
                let bookDict = book.value as! [String: Any]
                let currentBook = Book(bookID: book.key, bookDict: bookDict)
                self.books.append(currentBook)
            }
            completion()
            }
    }
}
