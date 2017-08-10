//
//  ProfileViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/30/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileView: HomeView!
    
    // Remove these properties
    fileprivate let leftAndRightPadding: CGFloat = 52.0
    fileprivate let itemsPerRow: CGFloat = 3.0
    fileprivate let heightAdjustment: CGFloat = 64.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.collectionView.delegate = self
        profileView.collectionView.dataSource = self

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
        
        print(CGSize(width: width, height: width + heightAdjustment))
        
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
