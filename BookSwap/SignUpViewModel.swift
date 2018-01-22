//
//  SignUpViewModel.swift
//  BookSwap
//
//  Created by Joyce Matos on 1/21/18.
//  Copyright © 2018 Joyce Matos. All rights reserved.
//

import Foundation

struct SignUpViewModel {
    unowned let view: SignUpViewable
    unowned let networkingService: NetworkingService
    
    init(view: SignUpViewable, networkingService: NetworkingService) {
        self.view = view
        self.networkingService = networkingService
    }
    
    func viewDidLoad() {
    }
    
    func didTapSignUp() {
    }
    
    func signUp() {
    }
    
    func createLibrary() {
    }
}
