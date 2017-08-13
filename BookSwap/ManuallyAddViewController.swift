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
            // Get Library ID
            firebaseManager.getLibrary(for: userID, completion: { (libraryID) in
                // Add Book
                
                book.userID = userID
                book.libraryID = libraryID
                
                
                self.addToRef(book)
                
                
                
                
                // self.add(book, to: libraryID, for: userID)
            })
        }
        
        
        
        
        // Attempt 2
        
        // Add book with userID to book ref
        // Retrieve latest book
        // Get user's libraryID and add ID to user
        // Go to library ref and create a books ref and set value to bookID with true
    }
    
}

// MARK: - API Methods
extension ManuallyAddViewController {
    
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
    
    
    func addToRef(_ book: Book) {
        
        firebaseManager.create(book) { (success) in
            if success {
                self.firebaseManager.retrieveID(for: book, completion: { (bookID) in
                    guard let libraryID = book.libraryID else {
                        
                        print("Well no libraryID")
                        // handle case
                        return
                    }
                    
                    var updatedBook = book
                    updatedBook.id = bookID
                    
                    self.firebaseManager.add(updatedBook, to: libraryID, completion: { (success) in
                        print("we in this add block tho")
                        if success {
                            print("We've added a book")
                        } else {
                            print("nopeeeee")
                        }
                    })
                })
                
            }
        }
        
        
    }
    
    
}
