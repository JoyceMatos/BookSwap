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
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(user?.firstName)
    }


}
