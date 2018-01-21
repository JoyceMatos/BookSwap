//
//  DetailedBookView.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/29/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class DetailedBookView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var tradeWithLabel: UILabel!
    @IBOutlet weak var ownerIcon: UIView!
    @IBOutlet weak var tradeBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(Nib.detailedBook, owner: self, options: nil)
        addSubview(contentView)
    }
}
