//
//  FirebaseAuthService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthService {
  // MARK: - FirebaseAuthService: Variables
    private let auth = Auth.auth()
    private var signInService = FirebaseSignInService()
    private var signUpService = FirebaseSignUpService()

  // MARK: - FirebaseAuthService: Methods
    public func signIn(signInType: SignInType, completion: @escaping SignInCompletion) {
      switch signInType {
      case let .emailAndPassword(email, password):
        signInService.signInWithPassword(email: email, password: password, completion: completion)
      case .checkSignIn:
        signInService.checkSignIn(completion: completion)
      }
    }

    public func signUp(signUpType: SignUpType, completion: @escaping SignUpCompletion) {
      switch signUpType {
      case let .emailAndPassword(email, password):
        signUpService.createAccountWithPassword(email: email, password: password, completion: completion)
      }
    }

    public func signOut(errorHandler: @escaping (Error?) -> Void) {
      do {
        try auth.signOut()
        errorHandler(nil)
      } catch {
        errorHandler(error)
      }
    }
}
