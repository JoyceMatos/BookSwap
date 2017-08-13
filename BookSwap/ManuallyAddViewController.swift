//
//  ManuallyAddViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/20/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit
import FirebaseAuth

class ManuallyAddViewController: UIViewController {
    // NOTE: - Manual view is just for testing
    
    @IBOutlet weak var manuallyAddBookView: ManuallyAddBookView!
    let firebaseManager = FirebaseManager()
    var user: User? // Is this ever used?
    var viewModel: ManuallyAddBookViewModel? // Is this ever used?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBookAction()
    }
    
    // TODO: - Use textfield delegate to retrieve values instead
    func retrieveValues() -> Book? {
        var book: Book?
        if let title = manuallyAddBookView.titleField.text,
            let author = manuallyAddBookView.authorField.text {
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
        
        if var book = book {
            // TODO: - Improve this
            firebaseManager.getLibrary(for: userID, completion: { (libraryID) in
                // Add Book
                book.userID = userID
                book.libraryID = libraryID
                self.add(book)
            })
        }
    }
    
}

// MARK: - API Methods
extension ManuallyAddViewController {
    
    func add(_ book: Book) {
        firebaseManager.create(book) { (bookID) in
            guard let libraryID = book.libraryID else {
                //handle case
                return
            }
            
            var updatedBook = book
            updatedBook.id = bookID
            
            self.firebaseManager.add(updatedBook, to: libraryID, completion: { (success) in
                if success {
                    print("We've added a book")
                } else {
                    print("nopeeeee")
                }
            })
        }
    }
    
    
}
