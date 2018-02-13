//
//  ViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/10/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UIKit

// TODO: - Remove anything that is not in use
// TODO: - Remove all string literals
// TODO: - Watch out for strong references
// TODO: - Add keyboard observers
// TODO: - Add extension for viewable 

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpView: SignUpView!
    var viewModel: UserViewModel!
    var vm: SignUpViewModel!
    let firebaseManager = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = Injector.currentInjector.signUpViewModel(view: self)
        addSignUpAction()
    }

    // TODO: - All logic will be stored on the view instead
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

    func signUp(for service: FirebaseManager, user: User, with password: String, completion: @escaping (Bool, String?) -> Void) {
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
    
    func createLibrary(for service: FirebaseManager, userID: String, completion: @escaping (String?) -> Void) {
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

extension SignUpViewController: SignUpViewable {
    var firstName: String {
        set {
            signUpView.firstNameField.text = newValue
        }
        get {
            return signUpView.firstNameField.text ?? ""
        }
    }
    
    var lastName: String {
        set {
            signUpView.lastNameField.text = newValue
        }
        get {
            return signUpView.lastNameField.text ?? ""
        }    }
    
    var email: String {
        set {
            signUpView.emailField.text = newValue
        }
        get {
            return signUpView.emailField.text ?? ""
        }    }
    
    var password: String {
        set {
            signUpView.passwordField.text = newValue
        }
        get {
            return signUpView.passwordField.text ?? ""
        }
    }
}


