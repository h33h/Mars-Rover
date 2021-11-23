//
//  FirebaseProfileWriteService.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

public enum ProfileActionType {
  // MARK: - Enum with Profile Actions
    case setupNewProfile
}

public enum ProfileWriteError {
  // MARK: - Enum with ProfileWrite error types
    case error(error: String)

    case profileNotExist

    case notSignedIn
}

typealias RWProfileCompletion = (ProfileWriteError?) -> Void

protocol FirebaseProfileWriteServiceProtocol {
  func profileAction(action: ProfileActionType, completion: @escaping RWProfileCompletion)
}

final class FirebaseProfileWriteService: FirebaseProfileWriteServiceProtocol {
  public func profileAction(action: ProfileActionType, completion: @escaping RWProfileCompletion) {
    switch action {
    case .setupNewProfile:
      setupNewProfile(completion: completion)
    }
  }

  private func setupNewProfile(completion: @escaping RWProfileCompletion) {
    guard let currentUser = Auth.auth().currentUser else { return completion(.notSignedIn) }
    Firestore.firestore().collection("users").document(currentUser.uid).setData(
      [
        "username": currentUser.email ?? currentUser.uid
      ]
    ) { error in
      if let error = error {
        return completion(.error(error: error.localizedDescription))
      }
      return completion(nil)
    }
  }
}
