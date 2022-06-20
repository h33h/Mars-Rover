//
//  FirebaseProfileService.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import FirebaseAuth
import FirebaseFirestore

final class FirebaseProfileService: FirebaseProfileServiceProtocol {
    func fetch(completion: @escaping FetchProfileCompletion) {
      guard let user = Auth.auth().currentUser else { return completion(nil, .notSignedIn) }
      let userRef = Firestore.firestore().collection(L10n.Network.FirebaseProfile.users).document(user.uid)
      userRef.getDocument { document, error in
        let result = Result {
          try document?.data(as: Profile.self)
        }
        switch result {
        case .success(let profileModel):
          if let profileModel = profileModel {
            return completion(profileModel, nil)
          } else {
            return completion(nil, .profileNotExist)
          }
        case .failure(let error):
          return completion(nil, .error(error.localizedDescription))
        }
      }
    }

  func profileAction(action: ProfileActionType, completion: @escaping WriteProfileCompletion) {
    switch action {
    case .setupNewProfile:
      setupNewProfile(completion: completion)
    }
  }

  private func setupNewProfile(completion: @escaping WriteProfileCompletion) {
    guard let currentUser = Auth.auth().currentUser else { return completion(.notSignedIn) }
    Firestore.firestore().collection(L10n.Network.FirebaseProfile.users).document(currentUser.uid).setData(
      [
        L10n.Network.FirebaseProfile.username: currentUser.email ?? currentUser.uid
      ]
    ) { error in
      if let error = error {
        return completion(.error(error.localizedDescription))
      }
      return completion(nil)
    }
  }
}
