//
//  SignUpView.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/14/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit
import Foundation

// TODO: - Separate any business logic
// TODO: - Pass this user along to next VC with segue

final class SignUpView: UIView {
    
    // MARK: - Properties
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var user: User?
    var viewModel: SignUpViewModel?
    
    // MARK: - View Lifecyle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("SignUpView", owner: self, options: nil)
        addSubview(contentView)
    }
    
    // TODO: - Refactor and validate inputs
    
    func retrieveAuthDetails() -> [String: Any] {
        var input = [String: Any]()
        if let firstName = firstNameField.text, let lastName = lastNameField.text, let email = emailField.text  {
            input = ["firstName": firstName, "lastName": lastName, "email": email]
            
        }
        return input
    }
    
    func retrievePassword() -> String {
        var password = String()
        if let input = passwordField.text  {
            password = input
        }
        return password
    }
    
    @IBAction func signUpButnTapped(_ sender: Any) {
        let userDetails = retrieveAuthDetails()
        let password = retrievePassword()
        viewModel = SignUpViewModel(userDetails: userDetails)
        user = viewModel?.createUser(from: userDetails)
        
        if let user = user {
            viewModel?.signUpTapped(by: user, with: password)
        }
        
    }
    
    
}
