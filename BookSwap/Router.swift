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

// NOTE: - This protocol will get the string value for any url endpoint

protocol Path {
    var path: String { get }
}


// NOTE: - This enum is used to determine what endpoint to retrieve

enum Endpoint {
    
    static let baseURL = "https://www.googleapis.com/"
    
    case getISBN(Int)
    
}

// NOTE: - This returns the appropriate endpoint string for any given enum

extension Endpoint: Path {
    
    var path: String {
        switch self {
        case .getISBN(let isbn):
            return "books/v1/volumes?q=isbn:\(isbn)"
        }
    }
    
}

// NOTE: - This returns the url for each enum case based on it's value

extension Endpoint {
    
    var url: URL? {
        switch self {
        case .getISBN:
            return generateURL(with: self.path)
        }
    }
    
}

// NOTE: - This generates a url from a string

extension Endpoint {
    
    func generateURL(with parameter: String) -> URL? {
        let string = Endpoint.baseURL + parameter + Secrets.googleKey 
        return URL(string: string)
    }
    
}

