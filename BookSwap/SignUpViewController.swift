//
//  ViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/10/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UIKit

// TODO: - Watch out for strong references
// TODO: - Add keyboard observers

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpView: SignUpView!
    var vm: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = Injector.currentInjector.signUpViewModel(view: self)
        addSignUpAction()
    }

    // MARK: - Action Methods
    func addSignUpAction() {
        signUpView.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    func signUpTapped() {
        vm.didTapSignUp()
    }
}

extension SignUpViewController: SignUpViewable {
    var firstName: String {
        get {
            return signUpView.firstNameField.text ?? ""
        }
        set {
            signUpView.firstNameField.text = newValue
        }
    }
    
    var lastName: String {
        get {
            return signUpView.lastNameField.text ?? ""
        }
        set {
            signUpView.lastNameField.text = newValue
        }
    }
    
    var email: String {
        get {
            return signUpView.emailField.text ?? ""
        }
        set {
            signUpView.emailField.text = newValue
        }
    }
    
    var password: String {
        get {
            return signUpView.passwordField.text ?? ""
        }
        set {
            signUpView.passwordField.text = newValue
        }
    }
    
    func showLocationScreen() {
        self.performSegue(withIdentifier: SegueIdentifier.showLocation, sender: nil)
    }
}
