//
//  ProfileViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/30/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit
import FirebaseAuth

// TODO: - Watch out for strong reference cycles
// TODO: - Get book objects

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileView: HomeView!
    let firebaseManager = FirebaseManager()
    
    // Remove these properties
    fileprivate let leftAndRightPadding: CGFloat = 52.0
    fileprivate let itemsPerRow: CGFloat = 3.0
    fileprivate let heightAdjustment: CGFloat = 64.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.collectionView.delegate = self
        profileView.collectionView.dataSource = self
        
        if let userID = Auth.auth().currentUser?.uid {
            getLibrary(for: firebaseManager, userID: userID) { (libraryID) in
                self.getBooks(for: self.firebaseManager, libraryID: libraryID, completion: { (bookIDs) in
                    self.getUsersBooks(for: self.firebaseManager, from: bookIDs, completion: { (books) in
                        
                        // TODO: - Create book objects out of these dictionaries
                        
                    })
                })
            }
        }
    }
    
    
    
}

extension ProfileViewController {
    
    func getLibrary(for service: NetworkingService, userID: String, completion: @escaping (String) -> Void) {
        service.getLibrary(for: userID) { (libraryID) in
            completion(libraryID)
        }
    }
    
    func getBooks(for service: NetworkingService, libraryID: String, completion: @escaping ([String]) ->Void) {
        service.retrieveBooks(from: libraryID) { (allBookIDS) in
            completion(allBookIDS)
        }
    }
    
    
    func getUsersBooks(for service: NetworkingService, from bookIDs: [String], completion: @escaping ([String:Any]) -> Void) {
        service.retrieveBooks(for: bookIDs) { (allBooks) in
            completion(allBooks)
        }
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Uh, not quick enough")
        //   return viewModel.books.count
        return DataStore.shared.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.bookCell, for: indexPath) as! BookCollectionViewCell
        cell.titleLabel.text = "My books"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - leftAndRightPadding) / itemsPerRow
        return CGSize(width: width, height: width + heightAdjustment)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.showDetailBook, sender: nil)
    }
    
    
    
    
}
