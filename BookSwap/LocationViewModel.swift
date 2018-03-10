//
//  LocationViewModel.swift
//  BookSwap
//
//  Created by Joyce Matos on 3/10/18.
//  Copyright © 2018 Joyce Matos. All rights reserved.
//

struct LocationViewModel {
    unowned let view: LocationViewable
    unowned let networkingService: FirebaseManager
    unowned let memoryCacheDataStore: MemoryCacheDataStoring
    
    init(view: LocationViewable, networkingService: FirebaseManager, memoryCacheDataStore: MemoryCacheDataStoring) {
        self.view = view
        self.networkingService = networkingService
        self.memoryCacheDataStore = memoryCacheDataStore
    }
    
    func didTapNext() {
        guard let userID = memoryCacheDataStore.cachedUserID, let location = Int(view.location) else {
            return
        }
        
        networkingService.addUserLocation(userID, location: location) { (success) in
            if success {
                self.view.showHomeScreen()
            } else {
//                completion(false, nil)
            }
        }
    }
}
