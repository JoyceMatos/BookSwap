//
//  MemoryCacheDataStoring.swift
//  BookSwap
//
//  Created by Joyce Matos on 2/12/18.
//  Copyright © 2018 Joyce Matos. All rights reserved.
//

protocol MemoryCacheDataStoring: class {
    var cachedUserID: String? { get set }
    var cachedLibraryID: String? { get set }
    var cachedLibrary: Library! { get set }
}
