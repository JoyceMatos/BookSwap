//
//  SignUpView.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/14/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

// TODO: - Separate any business logic

class SignUpView: UIView {
    
    // MARK: - Properties
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var user: User?
    
    lazy var viewModel: SignUpViewModel = {
        return SignUpViewModel(self.user)
    }()
    
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
    
    // NOTE: - Don't think this logic should be here
    func retrieveInput() {
        guard let firstName = firstNameField.text, let lastName = lastNameField, let email = emailField.text, let password = passwordField.text else {
            // TODO: - Handle this case
            return
        }
        
        let input: [String: Any] = ["firstName": firstName, "lastName": lastName, "email": email, "password": password]
        
        viewModel.createUser(from: input)
        
    }
    
    @IBAction func signUpButnTapped(_ sender: Any) {
        
        
        
    }
    
    
}
