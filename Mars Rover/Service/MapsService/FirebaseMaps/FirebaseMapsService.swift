//
//  FirebaseMapService.swift
//  Mars Rover
//
//  Created by XXX on 12.11.21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum FirebaseMapsServceError: Error {
  case notSignedIn
  case fetchFirebaseError
  case mapNotExist
  case textError(description: String)
}

typealias FirebaseMapModelCompletion = ([FirebaseMapModelData]?, FirebaseMapsServceError?) -> Void

protocol FirebaseMapsServceProtocol {
  func getMaps(completion: @escaping FirebaseMapModelCompletion)
  func mapAction(is action: FirebaseMapAction)
}

class FirebaseMapsServce: FirebaseMapsServceProtocol {
  private let mapActionService: FirebaseMapsActionServiceProtocol

  init(mapActionService: FirebaseMapsActionServiceProtocol) {
    self.mapActionService = mapActionService
  }

  func mapAction(is action: FirebaseMapAction) {
    mapActionService.mapAction(is: action)
  }

  func getMaps(completion: @escaping FirebaseMapModelCompletion) {
    guard let user = Auth.auth().currentUser else { return completion(nil, .notSignedIn) }
    let mapsRef = Firestore.firestore().collection("users").document(user.uid).collection("maps")
    mapsRef.getDocuments { documents, error in
      if let error = error {
        return completion(nil, .textError(description: error.localizedDescription))
      }
      guard let documents = documents else { return completion(nil, .fetchFirebaseError) }
      var maps: [FirebaseMapModelData] = []
      for document in documents.documents {
        let result = Result {
          try document.data(as: FirebaseMapModelData.self)
        }
        switch result {
        case .success(let mapModel):
          if let mapModel = mapModel {
            maps.append(mapModel)
          } else { return completion(nil, .mapNotExist) }
        case .failure(let error):
          return completion(nil, .textError(description: error.localizedDescription))
        }
      }
      return completion(maps, nil)
    }
  }
}
