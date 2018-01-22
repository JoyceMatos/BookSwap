//
//  HomeViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/20/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

// TODO: - Fix tabBar. It doesn't appear when you go back from a segue

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeView: HomeView!
    var viewModel: HomeViewModel!
    let firebaseManager = FirebaseManager()
    
    // Remove these properties
    fileprivate let leftAndRightPadding: CGFloat = 52.0
    fileprivate let itemsPerRow: CGFloat = 3.0
    fileprivate let heightAdjustment: CGFloat = 64.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - Initialize viewmodel like so: viewModel = Injector.homeViewModel()
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
        fetch(from: firebaseManager)
    }
}

// API Method
extension HomeViewController {
    func fetch(from service: NetworkingService) {
        DataStore.shared.getBooks(from: service) {
            DispatchQueue.main.async {
                self.viewModel = HomeViewModel(books: DataStore.shared.books)
                self.homeView.collectionView.reloadData()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        cell.titleLabel.text = viewModel.titleForBook(at: indexPath)
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

