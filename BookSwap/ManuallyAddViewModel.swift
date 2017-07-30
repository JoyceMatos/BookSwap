//
//  ManualAddViewModel.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/20/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UIKit

// TODO: - Add protocols for firebase methods

protocol AddBookDelegate {
    
    func add(_ book: Book, userID: String, completion: @escaping (Bool) -> Void)
    func retrieveAddedBook(_ completion: @escaping (String) -> Void)
    func updateUsers(_ uid: String, bookID: String, completion: @escaping (Bool) -> Void)
}

struct ManuallyAddBookViewModel {
    
    var userID: String?
    var libraryID: String?
    
    init(userID: String?) {
        self.userID = userID
    }
    
}
