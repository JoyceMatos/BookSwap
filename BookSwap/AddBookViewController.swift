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
        let book = retrieveValues()
        let userID = Auth.auth().currentUser?.uid
    
        // MARK: - Library Methods
        // TODO: - Carefully unwrap ID
        FirebaseManager.addLibrary(for: userID!) { (success) in
            if success {
                FirebaseManager.retreiveAddedLibrary({ (libraryID) in
                    // TODO: - Carefully unwrap ID
                    FirebaseManager.update(userID!, with: libraryID, completion: { (success) in
                        if success {
                            
                          //  self.add(book, to: libraryID, for: userID)

                            print("yay we have updated the user with library")
                        } else {
                            print("Womp, no books added to user")
                        }
                    })
                    
                })
                
            }
            
        }
        
    }
    
    func add(_ book: Book?, to libraryID: String, for userID: String?) {
        guard let bookID = book?.id, let book = book, let userID = userID else {
            return
        }
        
    FirebaseManager.add(book) { (success) in
        if success {
           
            FirebaseManager.add(bookID, to: libraryID, completion: { (success) in
                if success {
                    
                    print("BOOK IN LIBRARY")
                    // do something
                }
            })
            
            
            
        }
        }
        
    }
}
