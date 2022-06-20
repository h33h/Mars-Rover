//
//  FirebaseSignInService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import FirebaseAuth

final class FirebaseSignInService: FirebaseSignInServiceProtocol {
  func signIn(with type: SignInType, completion: @escaping SignInCompletion) {
    switch type {
    case let .emailAndPassword(email, password):
      signInWithPassword(email: email, password: password, completion: completion)
    }
  }

  private func signInWithPassword(email: String, password: String, completion: @escaping SignInCompletion) {
    Auth.auth().signIn(withEmail: email, password: password) { data, error in
      if let error = error {
        return completion(.error(error.localizedDescription))
      }
      guard let user = data?.user else { return completion(.absentOfUser) }
      guard user.isEmailVerified else {
        do {
          try Auth.auth().signOut()
          return completion(.notVerifiedEmail)
        } catch {
          return completion(.error(error.localizedDescription))
        }
      }
      return completion(nil)
    }
  }
}
