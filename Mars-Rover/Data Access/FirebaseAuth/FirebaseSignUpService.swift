//
//  FirebaseSignUpService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import FirebaseAuth

final class FirebaseSignUpService: FirebaseSignUpServiceProtocol {
  // MARK: - FirebaseSignUpService: SignUp Methods
  func signUp(with type: SignUpType, completion: @escaping SignUpCompletion) {
    switch type {
    case let .emailAndPassword(email, password):
      createAccountWithPassword(email: email, password: password, completion: completion)
    }
  }

  private func createAccountWithPassword(email: String, password: String, completion: @escaping SignUpCompletion) {
    Auth.auth().createUser(withEmail: email, password: password) { data, error in
      if let error = error {
        completion(.error(error.localizedDescription))
        return
      }
      guard let user = data?.user else { return completion(.absentOfUser) }
      user.sendEmailVerification { error in
        if let error = error {
          completion(.error(error.localizedDescription))
          return
        }
        do {
          try Auth.auth().signOut()
          return completion(nil)
        } catch {
          return completion(.error(error.localizedDescription))
        }
      }
    }
  }
}
