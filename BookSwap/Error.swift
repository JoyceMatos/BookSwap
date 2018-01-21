//
//  Error.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/30/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

// NOTE: - This protocol displays an error alert based on the type of error it is

// TODO: - Change protocol name to something more appropriate
protocol ErrorHandling: class {
    func displayErrorAlert(for type: ErrorType)
}


// NOTE: - This enum create an alert message for a particular error case
enum ErrorType {
    case retrievingBooks
    case deletingBook
    case deletingLibrary
    case editingBook
    case addingBook
    case missingFields
    
    var errorMessage: AlertMessage {
        switch self {
        case .retrievingBooks:
            return AlertMessage(title: "", message: "Had trouble retrieving books. Please try again later.")
        case .deletingBook:
            return AlertMessage(title: "", message: "Had trouble deleting book. Please try again later.")
        case .deletingLibrary:
            return AlertMessage(title: "", message: "Had trouble deleting library. Please try again later.")
        case .editingBook:
            return AlertMessage(title: "", message: "Had trouble editting book. Please try again later.")
        case .addingBook:
            return AlertMessage(title: "", message: "Had trouble adding book. Please try again later.")
        case .missingFields:
            return AlertMessage(title: "", message: "Please type in the title and/or author")
        }
    }
}
