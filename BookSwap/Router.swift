//
//  Router.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/17/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import UIKit

// NOTE: - This file is not in use

protocol Router: class {
    
    func route(to viewController: UIViewController, from originalViewController: UIViewController, with routeID: String)
    
    func route(to routeID: String, from context: UIViewController)
    
}

// TODO: - Give these string values and use as routeID in Router protocol

enum Route {
    
    case login
    case signUp
    case location
    
}
