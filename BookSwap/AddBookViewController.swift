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
// TODO: - Error handling

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
        
        guard let userID = user?.uid else {
            return
        }
        if let book = book {
            
            // 1. Get libraryID 
            // 2. Go to library branch and add bookID 
            // 3. Go to library book db and add book with id
            
            FirebaseManager.getLibrary(for: userID, completion: { (libraryID) in
                print("libraryID:", libraryID)
                print("UserID:", userID)
                self.add(book, to: libraryID, for: userID)

            })
            
            
        }

        
    }
    
    
    func add(_ book: Book, to libraryID: String, for userID: String) {
//        print("Are we adding the book?")
//        // Handle this case
//        var addedBook = book
//        FirebaseManager.add(book) { (success) in
//            print("Adding book to firebase db")
//            if success {
//                print("We'eve got a success?")
//                FirebaseManager.retreiveAddedBook({ (bookID) in
//                    print("Retrievingbook ID")
//                    addedBook.id = bookID
//                    FirebaseManager.add(bookID, to: libraryID, completion: { (success) in
//                        print("Ok now lets add the book to the library")
//                        if success {
//                            print("BOOK IN LIBRARY")
//                            // do something
//                        }
//                    })
//                    
//                })
//                
//            }
//        }
        
        
        
        FirebaseManager.add(book, to: libraryID) { (success) in
            if success {
                FirebaseManager.retrieveAddedBookID(from: libraryID, completion: { (bookID) in
                  //  book.id = bookID
                    
                    // TODO: - Attach userID and libraryID to book, pass the book into the following function, and fix the serialization for the book method to include userID & libraryID
                    var newBook = book
                    newBook.id = bookID
                    
                    FirebaseManager.add(newBook, completion: { (success) in
                        if success {
                            
                            
                        
                        } else {
                            print("Uh, think we need some more work")
                        }
                    })
                    print("ayyyyy heres the bookID:", bookID)
                })
                // 1. Observe last updated book and get ID
                print("We have a bookID in our library")
            } else {
                print("no bookID")
            }
        }
        
    }
    
    
    
    
}
