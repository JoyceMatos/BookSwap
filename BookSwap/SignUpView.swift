//
//  SignUpView.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/14/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit
import Foundation

// TODO: - ContentView may not be needed

class SignUpView: UIView {
    
    // MARK: - Properties
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
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
        Bundle.main.loadNibNamed(Nib.signUp, owner: self, options: nil)
        addSubview(contentView)
        updateTextFields()
        configureFields()
    }
    
    func configureFields() {
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    func updateTextFields() {
        firstNameField.underline()
        lastNameField.underline()
        emailField.underline()
        passwordField.underline()
    }
}

extension SignUpView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.returnKeyType = .done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
