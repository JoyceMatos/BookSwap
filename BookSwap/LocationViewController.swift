//
//  LocationViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/14/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

// TODO: - Create extension on textfields that retrieve & unwrap values
// TODO: - Refactor
// TODO: - Move business logic out!
// TODO: - Segues should pass viewModels as opposed to actual properties in all controllers!

class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationView: LocationView!
    var viewModel: UserViewModel!
    var delegate: LocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        addNextAction()
    }
    
    // TODO: - Check if is valid
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
        let stringLocation = retrieveLocation()
        let location = Int(stringLocation)
        viewModel.user.location = location
       delegate?.addLocation(for: viewModel.user) { (success, user) in
                if success {
                    self.performSegue(withIdentifier: SegueIdentifier.showTabBar, sender: nil )
                } else {
                    print("We have an error")
                    // Handle case
                }
            }
        }
}

extension LocationViewController: LocationDelegate {
    
    func addLocation(for user: User, completion: @escaping (Bool, User?) -> Void) {
        guard let userID = user.id, let location = user.location else {
            print("No user ID, no location")
            // Handle this
            return
        }
        
        FirebaseManager.addUserLocation(userID, location: location) { (success) in
            if success {
                completion(true, user)
            } else {
                completion(false, nil)
            }
        }
    }
}
