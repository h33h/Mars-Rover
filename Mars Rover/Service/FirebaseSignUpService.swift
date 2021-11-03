//
//  FirebaseSignUpService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import Foundation
import FirebaseAuth

enum SignUpType {

    // MARK: - Enum with signUp methods
    case emailAndPassword(email: String, password: String)

}

enum SignUpError {

    // MARK: - Enum with signIn error types
    case error(error: String)

    case unknownError

    case absentOfUser

}

typealias SignUpCompletion = (Bool?, SignUpError?) -> Void

class FirebaseSignUpService {

    // MARK: - FirebaseSignUpService: Variables
    private let auth = Auth.auth()

    // MARK: - FirebaseProfileService: SignUp Methods
    func createAccountWithPassword(email: String, password: String, completion: @escaping SignUpCompletion) {
        auth.createUser(withEmail: email, password: password) { [weak self] data, error in
            guard let strongSelf = self else { return completion(false, .unknownError) }
            if let error = error {
                completion(false, .error(error: error.localizedDescription))
                return
            }
            guard let user = data?.user else { return completion(false, .absentOfUser) }
            user.sendEmailVerification { error in
                if let error = error {
                    completion(false, .error(error: error.localizedDescription))
                    return
                }
                do {
                    try strongSelf.auth.signOut()
                    return completion(true, nil)
                } catch {
                    return completion(false, .error(error: error.localizedDescription))
                }
            }
        }
    }

}
