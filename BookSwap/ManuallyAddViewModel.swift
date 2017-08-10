//
//  ManualAddViewModel.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/20/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UIKit

struct ManuallyAddBookViewModel {
    
    var userID: String?
    var libraryID: String?
    
    init(userID: String?) {
        self.userID = userID
    }
    
}
