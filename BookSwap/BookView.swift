//
//  BookView.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/29/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class BookView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("BookView", owner: self, options: nil)
        addSubview(contentView)
        
    }

    

}
