//
//  FirebaseProfileService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

public enum ProfileFetchError {
  // MARK: - Enum with Profile error types
    case error(error: String)

    case profileNotExist

    case notSignedIn
}

typealias ProfileCompletion = (ProfileModel?, ProfileFetchError?) -> Void

protocol FirebaseProfileFetchServiceProtocol {
  func fetch(completion: @escaping ProfileCompletion)
}

final class FirebaseProfileFetchService: FirebaseProfileFetchServiceProtocol {
  // MARK: - FirebaseProfileService: Methods
    public func fetch(completion: @escaping ProfileCompletion) {
      guard let user = Auth.auth().currentUser else { return completion(nil, .notSignedIn) }
      let userRef = Firestore.firestore().collection("users").document(user.uid)
      userRef.getDocument { document, error in
        let result = Result {
          try document?.data(as: ProfileModel.self)
        }
        switch result {
        case .success(let profileModel):
          if let profileModel = profileModel {
            return completion(profileModel, nil)
          } else {
            return completion(nil, .profileNotExist)
          }
        case .failure(let error):
          return completion(nil, .error(error: error.localizedDescription))
        }
      }
    }
}
