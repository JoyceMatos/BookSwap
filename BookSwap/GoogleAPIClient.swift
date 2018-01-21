//
//  GoogleAPIClient.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/11/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

// TODO: - Refactor 

final class GoogleAPIClient {
    
    class func get(_ isbn: String, completion: @escaping (JSON?) -> Void) {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=isbn:" + isbn + "&key=" + Secrets.googleKey) else {
            // Handle
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as! JSON else {
                    completion(nil)
                    return
            }
            DispatchQueue.global(qos: .userInitiated).async {
                completion(responseJSON)
            }
        }
        task.resume()
    }
}
