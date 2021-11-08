//
//  FirebaseSignInService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import Foundation
import FirebaseAuth

public enum SignInType {
  // MARK: - Enum with signIn methods
    case emailAndPassword(email: String, password: String)

    case checkSignIn
}

public enum SignInError {
  // MARK: - Enum with signIn error types
    case error(error: String)

    case absentOfUser

    case notVerifiedEmail

    case notSignedIn

    case unknownError
}

typealias SignInCompletion = (Bool, SignInError?) -> Void

protocol SignInProtocol {
  func signIn(with type: SignInType, completion: @escaping SignInCompletion)
}

final class FirebaseSignInService: SignInProtocol {
  // MARK: - FirebaseSignInService: Variables
    private var authListener: AuthStateDidChangeListenerHandle?

  // MARK: - FirebaseSignInService: SignIn Methods
    public func signIn(with type: SignInType, completion: @escaping SignInCompletion) {
      switch type {
      case let .emailAndPassword(email, password):
        signInWithPassword(email: email, password: password, completion: completion)
      case .checkSignIn:
        checkSignIn(completion: completion)
      }
    }

    private func signInWithPassword(email: String, password: String, completion: @escaping SignInCompletion) {
      Auth.auth().signIn(withEmail: email, password: password) { data, error in
        if let error = error {
          return completion(false, .error(error: error.localizedDescription))
        }
        guard let user = data?.user else { return completion(false, .absentOfUser) }
        guard user.isEmailVerified else {
          do {
            try Auth.auth().signOut()
            return completion(false, .notVerifiedEmail)
          } catch {
            return completion(false, .error(error: error.localizedDescription))
          }
        }
        return completion(true, nil)
      }
    }

    private func checkSignIn(completion: @escaping SignInCompletion) {
      authListener = Auth.auth().addStateDidChangeListener { _, user in
        guard let user = user else { return completion(false, .notSignedIn) }
        guard user.isEmailVerified else {
          do {
            try Auth.auth().signOut()
            return completion(false, .notVerifiedEmail)
          } catch {
            return completion(false, .error(error: error.localizedDescription))
          }
        }
        return completion(true, nil)
      }
    }

  // MARK: - FirebaseSignInService: Deinit
    deinit {
      if let listener = authListener {
        Auth.auth().removeStateDidChangeListener(listener)
      }
    }
}
