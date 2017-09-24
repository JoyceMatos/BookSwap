//
//  DetailedBookViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/29/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

// TODO: - User should not be sending trade requests to themselves

class DetailedBookViewController: UIViewController {
    
    var viewModel = DetailedBookView()
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        DispatchQueue.main.async {
        print("Book title", self.book?.title)
        print("Book owner", self.book?.userID)
        }
        
    }
    
    // TODO: - Trade Info
    // 1. Get book's userID
    // 2. Go to user brance and retrieve necessary info
}
