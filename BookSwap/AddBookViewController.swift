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

struct State {
    
    var manualTapped: Bool
    var scannedTapped: Bool
}

// TODO: - Seperate state logic

class AddBookViewController: UIViewController {
    
    @IBOutlet weak var manualContainerView: UIView!
    @IBOutlet weak var scanContainerView: UIView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var addBookBar: AddBookBarView!
    
    var didTapManual = true
    var didTapScan = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonTargets()
        self.manualContainerView.alpha = 1.0
        self.scanContainerView.alpha = 0.0
        self.searchContainerView.alpha = 0.0
    }
    
    func addButtonTargets() {
        addBookBar.manualBtn.addTarget(self, action: #selector(manualTapped), for: .touchUpInside)
        addBookBar.scanBtn.addTarget(self, action: #selector(scanTapped), for: .touchUpInside)
        addBookBar.searchBtn.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
    }
    
    func manualTapped() {
        var didTapManual = true
        var didTapScan = false
        animateManualView()
    }
    
    func scanTapped() {
        var didTapManual = false
        var didTapScan = true
        animateScanView()
    }
    
    func searchTapped() {
        var didTapManual = false
        var didTapScan = true
        animateSearchView()
    }
    
    // MARK: - Animate Container Views
    func animateManualView() {
        UIView.animate(withDuration: 0.5) {
            self.manualContainerView.alpha = 1.0
            self.scanContainerView.alpha = 0.0
            self.searchContainerView.alpha = 0.0
        }
    }
    
    func animateScanView() {
        UIView.animate(withDuration: 0.5) {
            self.manualContainerView.alpha = 0.0
            self.scanContainerView.alpha = 1.0
            self.searchContainerView.alpha = 0.0
        }
    }
    
    func animateSearchView() {
        UIView.animate(withDuration: 0.5) {
            self.manualContainerView.alpha = 0.0
            self.scanContainerView.alpha = 0.0
            self.searchContainerView.alpha = 1.0
        }
    }
    
}


