//
//  FirebaseProfileService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public enum ProfileError {
  // MARK: - Enum with Profile error types
    case error(error: String)

    case profileNotExist
}

typealias ProfileCompletion = (ProfileModel?, ProfileError?) -> Void
typealias RWProfileCompletion = (Bool, ProfileError?) -> Void

final class FirebaseProfileService {
  // MARK: - FirebaseProfileService: Variables
    private var database = Firestore.firestore()

  // MARK: - FirebaseProfileService: Methods
    public func fetchProfileFromFirestore(uid: String, completion: @escaping ProfileCompletion) {
      let userRef = database.collection("users").document(uid)
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

    public func setupNewProfile(uid: String, completion: @escaping RWProfileCompletion) {
      database.collection("users").document(uid).setData(
        [
          "username": "Player"
        ]
      ) { error in
        if let error = error {
          return completion(false, .error(error: error.localizedDescription))
        }
        return completion(true, nil)
      }
    }
}
