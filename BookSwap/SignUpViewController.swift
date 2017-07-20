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
    var viewModel: SignUpViewModel?
    var user: User? // Not in use
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    func addSignUpAction() {
        signUpView.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    func signUpTapped() {
        let userDetails = retrieveAuthDetails()
        let password = userDetails["password"] as! String
        viewModel = SignUpViewModel(userDetails: userDetails)
        if let user = viewModel?.createUser(from: userDetails) {
            viewModel?.signUpTapped(by: user, with: password, completion: { (success, user) in
                if success {
                    self.viewModel?.user = user
                    // Send user with segue
                    self.performSegue(withIdentifier: SegueIdentifier.showLocation, sender: nil )
                } else {
                    print("ERRRORRRR (VC)")
                    // Handle this case
                }
            })
    }
    
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showLocation {
            let destVC = segue.destination as! LocationViewController
            destVC.user = viewModel?.user
        }
    }


}
