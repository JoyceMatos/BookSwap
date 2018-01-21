//
//  LocationView.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/16/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class LocationView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - View Lifecyle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(Nib.location, owner: self, options: nil)
        addSubview(contentView)
        
        updateTextField()
    }
    
    func updateTextField() {
        zipCodeField.underline()
    }
}
