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
    var viewModel: LocationViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = Injector.currentInjector.locationViewModel(view: self)

        addNextAction()
    }
    
    func addNextAction() {
        locationView.nextButton.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
    }
    
    func nextBtnTapped() {
        viewModel.didTapNext()
    }
}


extension LocationViewController: LocationViewable {
    var location: String {
        get {
            return locationView.zipCodeField.text ?? ""
        }
        set {
            locationView.zipCodeField.text = newValue
        }
    }
    
    func showHomeScreen() {
       self.performSegue(withIdentifier: SegueIdentifier.showTabBar, sender: nil )
    }
}
