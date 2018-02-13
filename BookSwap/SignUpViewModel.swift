//
//  SignUpViewModel.swift
//  BookSwap
//
//  Created by Joyce Matos on 1/21/18.
//  Copyright © 2018 Joyce Matos. All rights reserved.
//

import Foundation

struct SignUpViewModel {
    unowned let view: SignUpViewable
    unowned let networkingService: FirebaseManager
    unowned let memoryCacheDataStore: MemoryCacheDataStoring
    
    init(view: SignUpViewable, networkingService: FirebaseManager, memoryCacheDataStore: MemoryCacheDataStoring) {
        self.view = view
        self.networkingService = networkingService
        self.memoryCacheDataStore = memoryCacheDataStore
    }
    
    func viewDidLoad() {
    }
    
    func didTapSignUp() {
        let user = User(["firstName": view.firstName, "lastName": view.lastName, "email": view.email])
        networkingService.create(user, password: view.password, completion: { (success, user) in
            if success {
                self.memoryCacheDataStore.cachedUserID = user?.id
                // TODO: - Store User ID, Authenticate, and switch on a isLoggedInBool?
              //  completion(true, user?.id)
            } else {
                print("Error signing up")
              //  completion(false, nil)
                // Handle this error
            }
        })
        
        // TODO: - Create Library for user and segue on completion 
    }

    
    func createLibrary() {
        // TODO: - Get userID
        let userID = ""
        networkingService.addLibrary(for: userID) { (success) in
            if success {
                self.networkingService.retreiveAddedLibrary({ (libraryID) in
                    self.networkingService.update(userID, with: libraryID, completion: { (success) in
                        if success {
                         //   completion(libraryID)
                        } else {
                         //   completion(nil)
                        }
                    })
                })
            }
        }
    }
}
