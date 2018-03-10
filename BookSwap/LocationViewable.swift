//
//  LocationViewable.swift
//  BookSwap
//
//  Created by Joyce Matos on 3/10/18.
//  Copyright © 2018 Joyce Matos. All rights reserved.
//

protocol LocationViewable: class {
    var location: String { get set }
    
    func showHomeScreen()
}
