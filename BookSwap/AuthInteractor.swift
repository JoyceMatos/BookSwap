//
//  AuthInteractor.swift
//  BookSwap
//
//  Created by Joyce Matos on 2/12/18.
//  Copyright © 2018 Joyce Matos. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase

final class AuthInteractor {
    static var ref = Database.database().reference()
    
    init() { }
}

extension AuthInteractor {
    // TODO: - Refactor and split into two methods
    func createNewUser(_ newUser: User?, password: String, completion: @escaping (Bool, User?) -> Void) {
        guard var newUser = newUser else {
            print("no user") // TODO: - Handle Error
            return
        }
        
        Auth.auth().createUser(withEmail: newUser.email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    FirebaseManager.ref.child(Ref.users).child(user.uid).setValue(newUser.serialize(), withCompletionBlock: { (error, ref) in
                        newUser.id = user.uid
                        guard error == nil else {
                            // TODO: - Handle error
                            completion(false, nil)
                            return
                        }
                        completion(true, newUser)
                    }
                    )}
            } else {
                completion(false, nil)
            }
        })
    }
    
    func login(_ user: User?, password: String, completion: @escaping (Bool, User?) -> Void) {
        
    }


}
