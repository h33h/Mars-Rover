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

final class FirebaseSignInService {
  // MARK: - FirebaseSignInService: Variables
    private var authListener: AuthStateDidChangeListenerHandle?
    private let auth = Auth.auth()

  // MARK: - FirebaseSignInService: SignIn Methods
    public func signInWithPassword(email: String, password: String, completion: @escaping SignInCompletion) {
      auth.signIn(withEmail: email, password: password) { [weak self] data, error in
        guard let strongSelf = self else { return completion(false, .unknownError) }
        if let error = error {
          return completion(false, .error(error: error.localizedDescription))
        }
        guard let user = data?.user else { return completion(false, .absentOfUser) }
        guard user.isEmailVerified else {
          do {
            try strongSelf.auth.signOut()
            return completion(false, .notVerifiedEmail)
          } catch {
            return completion(false, .error(error: error.localizedDescription))
          }
        }
        return completion(true, nil)
      }
    }

    public func checkSignIn(completion: @escaping SignInCompletion) {
      authListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
        guard let strongSelf = self else { return completion(false, .unknownError) }
        guard let user = user else { return completion(false, .notSignedIn) }
        guard user.isEmailVerified else {
          do {
            try strongSelf.auth.signOut()
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
        auth.removeStateDidChangeListener(listener)
      }
    }
}
