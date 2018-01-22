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
// TODO: - Watch out for strong references
// TODO: - Add keyboard observers

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpView: SignUpView!
    var viewModel: UserViewModel!
    let firebaseManager = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSignUpAction()
    }
    
    // NOTE: - Does this logic belong here?
    // TODO: - Use textfield delegate to retrieve this info 
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
        
        signUp(for: firebaseManager, user: viewModel.user, with: password) { (success, id) in
            if success {
                if let id = id {
                    self.viewModel.user.id = id
                    self.createLibrary(for: self.firebaseManager, userID: id, completion: { (libraryID) in
                        self.viewModel.user.libraryID = libraryID
                    })
                    self.performSegue(withIdentifier: SegueIdentifier.showLocation, sender: nil)
                }
            }
            else {
                // Show error alert
            }
        }
    }
    
    // MARK: - Segue Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showLocation {
            let destVC = segue.destination as! LocationViewController
            destVC.viewModel = viewModel
        }
    }
}

// MARK: - API Methods

extension SignUpViewController {

    func signUp(for service: NetworkingService, user: User, with password: String, completion: @escaping (Bool, String?) -> Void) {
        service.create(user, password: password, completion: { (success, user) in
            if success {
                completion(true, user?.id)
            } else {
                print("Error signing up")
                completion(false, nil)
                // Handle this error
            }
        })
    }
    
    func createLibrary(for service: NetworkingService, userID: String, completion: @escaping (String?) -> Void) {
        service.addLibrary(for: userID) { (success) in
            if success {
                service.retreiveAddedLibrary({ (libraryID) in
                    service.update(userID, with: libraryID, completion: { (success) in
                        if success {
                            completion(libraryID)
                        } else {
                            completion(nil)
                        }
                    })
                })
            }
        }
    }
}


