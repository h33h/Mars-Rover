//
//  FirebaseSignUpService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

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

typealias SignUpCompletion = (SignUpError?) -> Void

protocol FirebaseSignUpServiceProtocol {
  func signUp(with type: SignUpType, completion: @escaping SignUpCompletion)
}

final class FirebaseSignUpService: FirebaseSignUpServiceProtocol {
  // MARK: - FirebaseProfileService: SignUp Methods
    public func signUp(with type: SignUpType, completion: @escaping SignUpCompletion) {
      switch type {
      case let .emailAndPassword(email, password):
        createAccountWithPassword(email: email, password: password, completion: completion)
      }
    }

    private func createAccountWithPassword(email: String, password: String, completion: @escaping SignUpCompletion) {
      Auth.auth().createUser(withEmail: email, password: password) { data, error in
        if let error = error {
          completion(.error(error: error.localizedDescription))
          return
        }
        guard let user = data?.user else { return completion(.absentOfUser) }
          user.sendEmailVerification { error in
            if let error = error {
              completion(.error(error: error.localizedDescription))
              return
            }
            do {
              try Auth.auth().signOut()
              return completion(nil)
            } catch {
              return completion(.error(error: error.localizedDescription))
            }
          }
      }
    }
}
