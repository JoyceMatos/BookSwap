//
//  ProfileHeader.swift
//  BookSwap
//
//  Created by Joyce Matos on 8/15/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class ProfileHeader: UIView {

    @IBOutlet var contentView: UIView!
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(Nib.profileHeader, owner: self, options: nil)
        addSubview(contentView)
    }
}
