//
//  AddBookViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/20/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

// TODO: - Swap manual view/viewModel for correct one

class AddBookViewController: UIViewController {

    // NOTE: - Manual view is just for testing
    
    @IBOutlet weak var manuallyAddBookView: ManuallyAddBookView!
    
    var viewModel: ManuallyAddBookViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //    func retrieveValues() -> Book? {
    //
    //    }
    
    func addBookTapped() {
     //   viewModel?.add(<#T##book: Book##Book#>, user: <#T##User?#>, completion: <#T##(Bool) -> Void#>)
    }

}
