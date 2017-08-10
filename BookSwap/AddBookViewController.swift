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
// TODO: - Redo how you're passing data into this tab bar
// TODO: - Refactor!!!
// TODO: - Error handling

class AddBookViewController: UIViewController {
    
    // NOTE: - Manual view is just for testing
    
    @IBOutlet weak var manuallyAddBookView: ManuallyAddBookView!
    let firebaseManager = FirebaseManager()
    var user: User? // Is this ever used?
    var viewModel: ManuallyAddBookViewModel? // Is this ever used?
    
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
        let user = Auth.auth().currentUser
        
        guard let userID = user?.uid else {
            return
        }
        
        if let book = book {
            // Get Library ID
            firebaseManager.getLibrary(for: userID, completion: { (libraryID) in
                // Add Book
                self.add(book, to: libraryID, for: userID)
            })
        }
    }
    
    
    func add(_ book: Book, to libraryID: String, for userID: String) {
        // Add bookID to library
        firebaseManager.add(book, to: libraryID) { (success) in
            if success {
                // Get bookID
                self.firebaseManager.retrieveAddedBookID(from: libraryID, completion: { (bookID) in
                    // Add book, library, and user ID to book
                    var newBook = book
                    newBook.id = bookID
                    newBook.userID = userID
                    newBook.libraryID = libraryID
                    // Add book to book node
                    self.firebaseManager.add(newBook, completion: { (success) in
                        if success {
                            // do something
                        } else {
                            // handle
                        }
                    })
                })
            } else {
                // handle
            }
        }
    }
    
    
    
    
}
