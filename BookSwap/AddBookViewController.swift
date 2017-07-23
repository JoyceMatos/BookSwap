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
        var book = retrieveValues()
        let userID = Auth.auth().currentUser?.uid
        viewModel = ManuallyAddBookViewModel(userID: userID )
        if let viewModel = viewModel, var book = book, let userID = userID {
        book.userID = userID
           viewModel.add(book, userID: userID, completion: { (success) in
            if success {
                viewModel.retrieveAddedBook({ (bookID) in
                    viewModel.updateUsers(userID, bookID: bookID, completion: { (success) in
                        if success {
                            print("yay we have updated the user")
                        } else {
                            print("Womp, no books added to user")
                        }
                    })
                })
            } else {
                print("Could not add book")
            }
           })
        }
    }
    
}
