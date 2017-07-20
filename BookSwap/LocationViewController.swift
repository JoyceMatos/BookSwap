//
//  LocationViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/14/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationView: LocationView!
    var viewModel: LocationViewModel?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    // TODO: - Check if is valid
    // TODO: - Separate business logic ; maybe this function should be on viewModel and take in a string
    func retrieveLocation() -> String {
        var location = String()
        
        if let zipCode = locationView.zipCodeField.text {
            location = zipCode
        }
        
        return location
    }
    
    func addNextAction() {
        locationView.nextButton.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
    }
    
    func nextBtnTapped() {
        guard let user = user  else {
            // Handle
            return
        }
        
        viewModel = LocationViewModel(user: user)

        if let viewModel = viewModel {
            viewModel.addLocation(for: user) { (success, user) in
                if success {
                    print("This is the user's location: \(user.location)")
                    // Segue
                } else {
                    // Handle case
                }
            }
        }
    }
    
    
}
