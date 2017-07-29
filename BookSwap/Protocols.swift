//
//  Protocols.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/27/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

protocol SignUpDelegate {
    
    func signUp(_ user: User, with password: String, completion: @escaping (Bool, String?) -> Void)
    
}

protocol LocationDelegate {
    
    func addLocation(for user: User, completion: @escaping (Bool, User?) -> Void)
}

protocol RetrieveBooksDelegate {
    
     func fetch(_ completion: @escaping () -> Void)
}



