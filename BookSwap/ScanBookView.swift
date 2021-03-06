//
//  ScanBookView.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/30/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class ScanBookView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scanLabel: UILabel!
    @IBOutlet weak var scanView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(Nib.scanView, owner: self, options: nil)
        addSubview(contentView)
    }
    

}
