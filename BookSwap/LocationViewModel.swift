//
//  Location.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/19/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

// NOTE: - Should this viewModel have a type user?

struct LocationViewModel {
    
    var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    func addLocation(for user: User, completion: @escaping (Bool, User?) -> Void) {
        guard let userID = user.id, let location = user.location else {
            print("No user ID, no location")
            // Handle this
            return
        }
        
        FirebaseManager.addUserLocation(userID, location: location) { (success) in
                if success {
                   completion(true, user)
                } else {
                    completion(false, nil)
                }
        }
    }
    
//    mutating func attach(_ location: String) {
//        let locationValue = Int(location)
//        user?.location = locationValue
//    }

    
}
