//
//  Book.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/11/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

struct Book {
    
    var id: String
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
    
    // Maybe?
    var location: String?

}
