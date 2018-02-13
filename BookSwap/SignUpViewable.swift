//
//  SignUpViewable.swift
//  BookSwap
//
//  Created by Joyce Matos on 1/21/18.
//  Copyright © 2018 Joyce Matos. All rights reserved.
//

protocol SignUpViewable: class {
    var firstName: String { get set }
    var lastName: String { get set}
    var email: String { get set }
    var password: String { get set }
}
