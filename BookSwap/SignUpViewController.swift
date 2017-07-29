//
//  ViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/10/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

// TODO: - Remove anything that is not in use
// TODO: - Remove all string literals

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpView: SignUpView!
    var viewModel: UserViewModel!
    var delegate: SignUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        addSignUpAction()
    }
    
    // NOTE: - Does this logic belong here?
    func retrieveAuthDetails() -> [String: Any] {
        var input = [String: Any]()
        
        if let firstName = signUpView.firstNameField.text,
            let lastName = signUpView.lastNameField.text,
            let email = signUpView.emailField.text,
            let password = signUpView.passwordField.text {
            input = ["firstName": firstName, "lastName": lastName, "email": email, "password": password]
        }
        
        return input
    }
    
    // MARK: - Action Methods
    
    func addSignUpAction() {
        signUpView.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    func signUpTapped() {
        let userDetails = retrieveAuthDetails()
        let password = userDetails["password"] as! String
        viewModel = UserViewModel(userDetails: userDetails)
        
        delegate?.signUp(viewModel.user, with: password, completion: { (success, id) in
            if success {
                self.viewModel.user.id = id
                self.performSegue(withIdentifier: SegueIdentifier.showLocation, sender: nil)
            }
            else {
                // Show error alert
            }
        })
        
    }

    // MARK: - Segue Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showLocation {
            let destVC = segue.destination as! LocationViewController
            destVC.viewModel = viewModel
        }
    }
}

// MARK: - Delegate Method

extension SignUpViewController: SignUpDelegate {
    
    func signUp(_ user: User, with password: String, completion: @escaping (Bool, String?) -> Void) {
        FirebaseManager.create(user, password: password, completion: { (success, user) in
            if success {
                completion(true, user?.id)
            } else {
                print("Error signing up")
                completion(false, nil)
                // Handle this error
            }
        })
    }
}
