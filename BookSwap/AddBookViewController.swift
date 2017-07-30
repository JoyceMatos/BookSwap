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
        
        /* New Implementations:
         1. Create library with corresponding ID in DB
         3. Retrieve library ID
         2. Add libraryID to user's info
         3. Create book with corresponding book info (including library ID)
         */
        
        // MARK: - Library Methods
        // TODO: - Carefully unwrap ID
        FirebaseManager.addLibrary(for: userID!) { (success) in
            if success {
                
                
                
                FirebaseManager.retreiveAddedLibrary({ (libraryID) in
                    // TODO: - Carefully unwrap ID
                    FirebaseManager.update(userID!, with: libraryID, completion: { (success) in
                        if success {
                            print("yay we have updated the user with library")
                        } else {
                            print("Womp, no books added to user")
                        }
                    })
                    
                    
                })
                
            }
            
        }
        
    
            // MARK: - Book Methods
            //        viewModel = ManuallyAddBookViewModel(userID: userID )
            //        if let viewModel = viewModel, var book = book, let userID = userID {
            //        book.userID = userID
            //           viewModel.add(book, userID: userID, completion: { (success) in
            //            if success {
            //                viewModel.retrieveAddedBook({ (bookID) in
            //                    print("Yay we have added a book to books")
            //                // TODO: - Add book ID to library ID?
            //
            //                })
            //            } else {
            //                print("Could not add book")
            //            }
            //           })
            //        }
            //        
            //        
            //   }
    }
}
