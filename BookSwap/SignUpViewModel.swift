//
//  SignUpViewModel.swift
//  BookSwap
//
//  Created by Joyce Matos on 1/21/18.
//  Copyright © 2018 Joyce Matos. All rights reserved.
//

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
                self.createLibrary()
                self.view.showLocationScreen()
                // TODO: - Store User ID, Authenticate, and switch on a isLoggedInBool?
              //  completion(true, user?.id)
            } else {
                print("Error signing up")
              //  completion(false, nil)
                // Handle this error
            }
        })
        
    }

    
    func createLibrary() {
        guard let userID = memoryCacheDataStore.cachedUserID else {
            return
        }
        
        networkingService.addLibrary(for: userID) { (success) in
            if success {
                self.networkingService.retreiveAddedLibrary({ (libraryID) in
                    self.networkingService.update(userID, with: libraryID, completion: { (success) in
                        if success {
                            self.memoryCacheDataStore.cachedLibraryID = libraryID
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
