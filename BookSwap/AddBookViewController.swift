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
// TODO: - Work on book method

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
        let user = Auth.auth().currentUser
        
        // MARK: - Library Methods
        // TODO: - Carefully unwrap ID
        
        guard let userID = user?.uid else {
            return
        }
        
        FirebaseManager.addLibrary(for: userID) { (success) in
            if success {
                FirebaseManager.retreiveAddedLibrary({ (libraryID) in
                    FirebaseManager.update(userID, with: libraryID, completion: { (success) in
                        if success {
                            book?.libraryID = libraryID
                            print("Library id", book?.libraryID ?? "no library id")
                        } else {
                            print("Womp, no books added to user")
                        }
                    })
                    
                })
                
            }
        }
        
        
//        if let book = book {
//            print("book?")
//            if let libraryID = book.libraryID {
//                print("LibraryID?")
//                print("Hello dispatch")
//                self.add(book, to: libraryID, for: userID)
//            }
//            
//        }
    }
    
    
    func add(_ book: Book, to libraryID: String, for userID: String) {
        print("Are we adding the book?")
        // Handle this case
        var addedBook = book
        FirebaseManager.add(book) { (success) in
            print("Adding book to firebase db")
            if success {
                FirebaseManager.retreiveAddedBook({ (bookID) in
                    print("Retrievingbook ID")
                    addedBook.id = bookID
                    FirebaseManager.add(bookID, to: libraryID, completion: { (success) in
                        print("Ok now lets add the book to the library")
                        if success {
                            print("BOOK IN LIBRARY")
                            // do something
                        }
                    })
                    
                })
                
            }
        }
        
    }
    
    
    
    
}
