//
//  Injector.swift
//  BookSwap
//
//  Created by Joyce Matos on 1/21/18.
//  Copyright © 2018 Joyce Matos. All rights reserved.
//

class Injector {
    
    init() {}
    
    let networkingService: FirebaseManager! = nil
    let dataStore: DataStore! = nil
    
    // MARK: - ViewModels
    func signUpViewModel() -> SignUpViewModel {
        return SignUpViewModel(networkingService: networkingService)
    }
    
    // TODO: - This should take in data store
    func homeViewModel() -> HomeViewModel {
      return  HomeViewModel(books: <#T##[Book]#>) // This should take in the data store instead
    }
    
    // TODO: - This should take in a networking service
    func manuallyAddViewModel() -> ManuallyAddBookViewModel {
       return ManuallyAddBookViewModel(userID: <#T##String?#>)
    }
}
