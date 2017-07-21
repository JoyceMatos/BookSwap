//
//  ManualAddViewModel.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/20/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UIKit

struct ManuallyAddBookViewModel {
    
    var userID: String?
    
    init(userID: String?) {
        self.userID = userID
    }
    
    func add(_ book: Book, userID: String, completion: @escaping (Bool) -> Void) {
            FirebaseManager.add(book, userID: userID, completion: { (success) in
                if success {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    
}
