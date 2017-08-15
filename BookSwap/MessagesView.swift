//
//  MessagesView.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/30/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class MessagesView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "cellID"
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(Nib.messageView, owner: self, options: nil)
        tableView.register(UINib(nibName: Nib.messageCell, bundle: nil), forCellReuseIdentifier: "cellID")
        addSubview(contentView)
    }

}
