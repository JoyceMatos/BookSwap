//
//  LoginView.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/11/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    // MARK: - Properties
 
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var viewModel: LoginViewModel?
    
    // MARK: - View Lifecyle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTextFieldInput() -> [String: Any] {
        let input = ["firstName": self.firstNameField.text, "lastName": self.lastNameField.text, "email": self.emailField.text]
        return input
    }

    // MARK: - Action Method
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        
    }
    
    

}
