//
//  Injector.swift
//  BookSwap
//
//  Created by Joyce Matos on 1/21/18.
//  Copyright © 2018 Joyce Matos. All rights reserved.
//

class Injector {
    
    private static var injector: Injector!
    
    static var currentInjector: Injector {
        return injector
    }
    
    static func setInjector(_ injector: Injector) {
        self.injector = injector
    }
        
    init() {
        networkingService = FirebaseManager()
        dataStore = DataStore.shared
        memoryCacheDataStore = MemoryCacheDataStore()
    }
    
    var networkingService: FirebaseManager! = nil
    var dataStore: DataStore! = nil
    var memoryCacheDataStore: MemoryCacheDataStoring! = nil
    
    // MARK: - ViewModels
    func signUpViewModel(view: SignUpViewable) -> SignUpViewModel {
        return SignUpViewModel(view: view, networkingService: networkingService, memoryCacheDataStore: memoryCacheDataStore)
    }
    
    // TODO: - This should take in data store
//    func homeViewModel() -> HomeViewModel {
//      return  HomeViewModel(books: <#T##[Book]#>) // This should take in the data store instead
//    }
//    
//    // TODO: - This should take in a networking service
//    func manuallyAddViewModel() -> ManuallyAddBookViewModel {
//       return ManuallyAddBookViewModel(userID: <#T##String?#>)
//    }
}
