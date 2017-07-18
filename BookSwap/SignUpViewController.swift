//
//  ViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/10/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var signUpView: SignUpView! {
        didSet {
            let firstName = Dynamic(signUpView.firstNameField.text)
            let lastName = Dynamic(signUpView.lastNameField.text)
            let email = Dynamic(signUpView.emailField.text)
            
            let input = ["firstName": firstName, "lastName": lastName, "email": email]
            self.viewModel = SignUpViewModel(userDetails: input)
            self.user = User(input)
            
            print(input)
        }
    }
    
    
    var viewModel: SignUpViewModel?
    
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   instantiateViewModel()
        
    }
    
    
    
//    func retrieveAuthDetails() -> [String: Any] {
//        var input = [String: Any]()
//        
//        if let firstName = signUpView.firstNameField.text,
//            let lastName = signUpView.lastNameField.text,
//            let email = signUpView.emailField.text {
//            input = ["firstName": firstName, "lastName": lastName, "email": email]
//        }
//        
//        return input
//    }
//    
//    func instantiateViewModel() {
//        let userDetails = retrieveAuthDetails()
//        viewModel = SignUpViewModel(userDetails: userDetails)
//    }
//    
//    func bindSignInData() {
//        signUpView.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
//        
//    }
//    
//    func signUpTapped() {
//        if let password = signUpView.passwordField.text, let user = user {
//            viewModel.signUpTapped(by: user, with: password, completion: { (success) in
//                if success {
//                    self.performSegue(withIdentifier: SegueIdentifier.showLocation, sender: nil )
//                } else {
//                    print("ERRRORRRR (VC)")
//                    // Handle this case
//                }
//            })
//        }
//    }
    
    
    
    
}



