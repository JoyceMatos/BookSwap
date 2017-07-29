//
//  HomeViewModel.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/20/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

struct HomeViewModel {
    
    let books = DataStore.shared.books
    let numberOfSections = 1

    let reuseIdentifier = "bookCell"
    
}


