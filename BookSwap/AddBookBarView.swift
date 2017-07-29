//
//  AddBookView.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/20/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class AddBookBarView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var manualBtn: UIButton!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(Nib.addBookBar, owner: self, options: nil)
        addSubview(contentView)
    }
    
}
