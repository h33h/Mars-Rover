//
//  FirebaseRegisterService.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum RegisterType {
    case emailAndPassword(email: String, password: String)
}

enum RegisterError {
    case error(error: String)
    case absentOfUser
    case noEmail
}

typealias RegisterCompletion = (Bool?, RegisterError?) -> Void

class FirebaseRegisterService {
    private let auth = Auth.auth()
    private var db = Firestore.firestore()
    func createAccountWithPassword(email: String, password: String, completion: @escaping RegisterCompletion) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                completion(false, .error(error: error.localizedDescription))
                return
            }
            guard let user = result?.user else { return completion(false, .absentOfUser) }
            guard let email = user.email else { return completion(false, .noEmail) }
            self?.setupNewProfile(uid: user.uid, email: email)
            user.sendEmailVerification { error in
                if let error = error {
                    completion(false, .error(error: error.localizedDescription))
                    return
                }
                try? self?.auth.signOut()
                completion(true, nil)
            }
        }
    }
    private func setupNewProfile(uid: String, email: String) {
        db.collection("users").document(uid).setData([ "username": email ], merge: true)
    }
}
