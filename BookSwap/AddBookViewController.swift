//
//  AddBookViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/20/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


// TODO: - Swap manual view/viewModel for correct one
// TODO: - Redo how you're passingdata into this tab bar

class AddBookViewController: UIViewController {
    
    // NOTE: - Manual view is just for testing
    
    @IBOutlet weak var manuallyAddBookView: ManuallyAddBookView!
    
    var user: User?
    var viewModel: ManuallyAddBookViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBookAction()
        
    }
    
    func retrieveValues() -> Book? {
        var book: Book?
        
        if let title = manuallyAddBookView.titleField.text, let author = manuallyAddBookView.authorField.text {
            book = Book(title: title, author: author)
        }
        
        return book
    }
    
    func addBookAction() {
        manuallyAddBookView.addBookButton.addTarget(self, action: #selector(addBookTapped), for: .touchUpInside)
        
    }
    
    func addBookTapped() {
        let book = retrieveValues()
        let userID = Auth.auth().currentUser?.uid
        viewModel = ManuallyAddBookViewModel(userID: userID )
        if let viewModel = viewModel, let book = book, let userID = userID {
            viewModel.add(book, userID: userID, completion: { (success) in
                if success {
                    // yay do something
                } else {
                    // uh oh, handle case
                }
            })
        }
    }
    
}
