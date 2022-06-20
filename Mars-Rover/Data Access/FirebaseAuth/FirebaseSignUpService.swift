//
//  FirebaseSignUpService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import FirebaseAuth

final class FirebaseSignUpService: FirebaseSignUpServiceProtocol {
  var profileService: FirebaseProfileServiceProtocol?

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
      user.sendEmailVerification { [weak self] error in
        if let error = error {
          completion(.error(error.localizedDescription))
          return
        }
        self?.profileService?.profileAction(action: .setupNewProfile) { error in
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
}
