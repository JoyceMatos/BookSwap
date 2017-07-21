//
//  Book.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/11/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

struct Book {
    
    var id: String?
    var title: String
    var author: String
    var publisher: String?
    var publishedDate: Date?
    var description: String?
    var pageCount: Int?
    var categories: String?
    var language: String?
    var isbn: Int?
    var thumbnail: URL?
    var userID: String?
    
    // Maybe?
    var location: String?
    
    // Just the basics for now
    func serialize() -> [String: Any] {
        var bookValue = [String: Any]()
        
        if let userID = userID {
            bookValue["title"] = title
            bookValue["author"] = author
            bookValue["userID"] = userID
            
        }
        
        return bookValue
    }
    
}

extension Book {
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
    
}
