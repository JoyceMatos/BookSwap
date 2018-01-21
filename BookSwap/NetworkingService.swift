//
//  NetworkingService.swift
//  BookSwap
//
//  Created by Joyce Matos on 8/8/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

// TODO: - Remove any method that is not in use

protocol NetworkingService: class {
    // Authentication
    func authenticate(_ newUser: User?, password: String, completion: @escaping (Bool, User?) -> Void)
    
    // Users
    func create(_ newUser: User?, password: String, completion: @escaping (Bool, User?) -> Void)
    func addUserLocation(_ uid: String, location: Int, completion: @escaping (Bool) -> Void)
    func update(_ userID: String, with libraryID: String, completion: @escaping (Bool) -> Void)
    func getLibrary(for userID: String, completion: @escaping (String) -> Void)
    
    // Books
    func add(_ book: Book, completion: @escaping (Bool) -> Void)
    func retrieveAllBooks(_ completion: @escaping ([String: Any]) -> Void)
    func retrieveBooks(for bookIDs: [String], completion: @escaping ([String: Any]) -> Void)    
    func create(_ book: Book, completion: @escaping (String?) -> Void)
    
    // Libraries
    func addLibrary(for userID: String, completion: @escaping (Bool) -> Void)
    func add(_ book: Book, to libraryID: String, completion: @escaping (Bool) -> Void)
    func retreiveAddedLibrary(_ completion: @escaping (String) -> Void) 
    func retrieveBooks(from libraryID: String, completion: @escaping ([String]) -> Void)
    func retrieveAddedBookID(from libraryID: String, completion: @escaping (String) -> Void)
}
