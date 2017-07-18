//
//  ViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/10/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var signUpView: SignUpView!
//    var viewModel: SignUpViewModel {
//        didSet {
//            viewModel.firstName.bindAndFire { [unowned self] in
//                viewModel.userDetails = viewModel.createUser(from: <#T##[String : Any]#>)
//            }
//            
//            
//            
//            
//        }
//    }
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func signUpTapped(for user: User) {
        performSegue(withIdentifier: SegueIdentifier.showLocation, sender: user)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        viewModel.handle(segue: segue, withSender: sender)
    }
    

    
}



