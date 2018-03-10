//
//  MemoryCacheDataStore.swift
//  BookSwap
//
//  Created by Joyce Matos on 2/12/18.
//  Copyright © 2018 Joyce Matos. All rights reserved.
//

class MemoryCacheDataStore: MemoryCacheDataStoring {
    var cachedUserID: String?
    var cachedLibrary: Library!
    var cachedLibraryID: String?
    
    func clear() {
        cachedLibrary = nil
    }
}
