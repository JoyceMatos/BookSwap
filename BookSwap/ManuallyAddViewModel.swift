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
    
    var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    func add(_ book: Book, user: User?, completion: @escaping (Bool) -> Void) {
        if let user = user {
            FirebaseManager.add(book, user: user, completion: { (success) in
                if success {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    }
    
}
