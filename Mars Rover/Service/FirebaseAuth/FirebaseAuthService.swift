//
//  FirebaseAuthService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthServiceProtocol {
  func signIn(with type: SignInType, completion: @escaping SignInCompletion)
  func signUp(with type: SignUpType, completion: @escaping SignUpCompletion)
  func signOut(errorHandler: @escaping (Error?) -> Void)
}

final class FirebaseAuthService: FirebaseAuthServiceProtocol {
  // MARK: - FirebaseAuthService: Variables
    static var shared = FirebaseAuthService(
      signInService: FirebaseSignInService(),
      signUpService: FirebaseSignUpService()
    )
    let signInService: FirebaseSignInServiceProtocol
    let signUpService: FirebaseSignUpServiceProtocol

  // MARK: - FirebaseAuthService: Init Methods
    init(signInService: FirebaseSignInServiceProtocol, signUpService: FirebaseSignUpServiceProtocol) {
      self.signInService = signInService
      self.signUpService = signUpService
    }

  // MARK: - FirebaseAuthService: Methods
    func signIn(with type: SignInType, completion: @escaping SignInCompletion) {
      signInService.signIn(with: type, completion: completion)
    }

    func signUp(with type: SignUpType, completion: @escaping SignUpCompletion) {
      signUpService.signUp(with: type, completion: completion)
    }

    func signOut(errorHandler: @escaping (Error?) -> Void) {
      do {
        try Auth.auth().signOut()
        errorHandler(nil)
      } catch {
        errorHandler(error)
      }
    }
}
