//
//  FirebaseAuthService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import FirebaseAuth

final class FirebaseAuthService: FirebaseAuthServiceProtocol {
  var signInService: FirebaseSignInServiceProtocol?
  var signUpService: FirebaseSignUpServiceProtocol?

  func signIn(with type: SignInType, completion: @escaping SignInCompletion) {
    signInService?.signIn(with: type, completion: completion)
  }

  func signUp(with type: SignUpType, completion: @escaping SignUpCompletion) {
    signUpService?.signUp(with: type, completion: completion)
  }

  func signOut(completion: @escaping SignOutCompletion) {
    do {
      try Auth.auth().signOut()
      completion(nil)
    } catch {
      completion(error)
    }
  }
}
