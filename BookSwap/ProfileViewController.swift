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
// TODO: - Add viewModel

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileView: HomeView!
    let firebaseManager = FirebaseManager()
    let store = DataStore.shared
    
    // Remove these properties
    fileprivate let leftAndRightPadding: CGFloat = 52.0
    fileprivate let itemsPerRow: CGFloat = 3.0
    fileprivate let heightAdjustment: CGFloat = 64.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.collectionView.delegate = self
        profileView.collectionView.dataSource = self
        getUsersBooks()
    }
    
    func getUsersBooks() {
        if let userID = Auth.auth().currentUser?.uid {
            store.getUsersBooks(from: firebaseManager, for: userID, completion: { (success) in
                if success {
                        self.profileView.collectionView.reloadData()
                } else {
                    // Handle this case
                    print("uh oh, error")
                }
            })
        }
    }
    
    
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //   return viewModel.books.count
        return store.usersBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.bookCell, for: indexPath) as! BookCollectionViewCell
        let book = store.usersBooks[indexPath.row]
        cell.titleLabel.text = book.title
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
        performSegue(withIdentifier: SegueIdentifier.userBookDetails, sender: nil)
    }
    
}
