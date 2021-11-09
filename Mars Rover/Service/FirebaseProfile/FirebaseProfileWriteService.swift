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

typealias RWProfileCompletion = (Bool, ProfileWriteError?) -> Void

protocol ProfileWriteProtocol {
  func profileAction(action: ProfileActionType, completion: @escaping RWProfileCompletion)
}

class FirebaseProfileWriteService: ProfileWriteProtocol {
  public func profileAction(action: ProfileActionType, completion: @escaping RWProfileCompletion) {
    switch action {
    case .setupNewProfile:
      setupNewProfile(completion: completion)
    }
  }

  private func setupNewProfile(completion: @escaping RWProfileCompletion) {
    guard let currentUser = Auth.auth().currentUser else { return completion(false, .notSignedIn) }
    Firestore.firestore().collection("users").document(currentUser.uid).setData(
      [
        "username": currentUser.email ?? currentUser.uid
      ]
    ) { error in
      if let error = error {
        return completion(false, .error(error: error.localizedDescription))
      }
      return completion(true, nil)
    }
  }
}
