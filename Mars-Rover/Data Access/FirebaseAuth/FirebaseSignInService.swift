//
//  FirebaseSignInService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import FirebaseAuth

final class FirebaseSignInService: FirebaseSignInServiceProtocol {
  // MARK: - FirebaseSignInService: Variables
  private var authListener: AuthStateDidChangeListenerHandle?

  // MARK: - FirebaseSignInService: SignIn Methods
  func signIn(with type: SignInType, completion: @escaping SignInCompletion) {
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

  private func checkSignIn(completion: @escaping SignInCompletion) {
    authListener = Auth.auth().addStateDidChangeListener { _, user in
      guard let user = user else { return completion(.notSignedIn) }
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

  // MARK: - FirebaseSignInService: Deinit
  deinit {
    if let listener = authListener {
      Auth.auth().removeStateDidChangeListener(listener)
    }
  }
}
