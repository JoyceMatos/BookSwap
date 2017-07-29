//
//  HomeViewModel.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/20/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

struct HomeViewModel {
    
    let books: [Book]
    
    static let numberOfSections = 1
    private let leftAndRightPadding = 32.0
    private let itemsPerRow = 3.0
    private let heightAdjustment = 64.0
    private let sectionInsets = ["top": 8.0, "left": 8.0, "bottom": 8.0, "right": 8.0]
    
    init(books: [Book]) {
        self.books = books
    }
    
    let reuseIdentifier = "bookCell"
    
    func titleForBook(at indexPath: IndexPath) -> String {
        let book = books[indexPath.item]
        return book.title
    }
    
    func authorForBook(at indexPath: IndexPath) -> String {
        let book = books[indexPath.item]
        return book.author
    }
    
    func publisherForBook(at indexPath: IndexPath) -> String? {
        let book = books[indexPath.item]
        return book.publisher
    }
    
    func categoriesForBook(at indexPath: IndexPath) -> String? {
        let book = books[indexPath.item]
        return book.categories
    }
    
    func locationForBook(at indexPath: IndexPath) -> String? {
        let book = books[indexPath.item]
        return book.location
    }
    
    func ownerIDForBook(at indexPath: IndexPath) -> String? {
        let book = books[indexPath.item]
        return book.userID
    }
    
}


