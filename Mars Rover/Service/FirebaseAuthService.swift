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
    public var signInService: SignInProtocol
    public var signUpService: SignUpProtocol

  // MARK: - FirebaseAuthService: Init Methods
    init(signInService: SignInProtocol, signUpService: SignUpProtocol) {
      self.signInService = signInService
      self.signUpService = signUpService
    }

  // MARK: - FirebaseAuthService: Methods
    public func signOut(errorHandler: @escaping (Error?) -> Void) {
      do {
        try Auth.auth().signOut()
        errorHandler(nil)
      } catch {
        errorHandler(error)
      }
    }
}
