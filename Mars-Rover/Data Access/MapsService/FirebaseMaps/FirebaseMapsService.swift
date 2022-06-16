//
//  FirebaseMapsService.swift
//  Mars Rover
//
//  Created by XXX on 12.11.21.
//

import FirebaseAuth
import FirebaseFirestore

final class FirebaseMapsService: FirebaseMapsServiceProtocol {
  static var shared = FirebaseMapsService(mapActionService: FirebaseMapsActionService())
  private let mapActionService: FirebaseMapsActionServiceProtocol

  init(mapActionService: FirebaseMapsActionServiceProtocol) {
    self.mapActionService = mapActionService
  }

  func mapAction(
    is action: FirebaseMapAction,
    errorHandler: @escaping FirebaseMapActionCompletion
  ) {
    mapActionService.mapAction(is: action, errorHandler: errorHandler)
  }

  func getMaps(completion: @escaping FirebaseMapModelCompletion) {
    guard
      let user = Auth.auth().currentUser
    else { return completion(nil, .notSignedIn) }

    let mapsRef = Firestore
      .firestore()
      .collection("users")
      .document(user.uid)
      .collection("maps")

    mapsRef.getDocuments { documents, error in
      if let error = error {
        return completion(nil, .error(error.localizedDescription))
      }

      guard
        let documents = documents
      else { return completion(nil, .fetchFirebaseError) }

      var maps: [FirebaseMap] = []

      for document in documents.documents {
        let result = Result {
          try document.data(as: FirebaseMap.self)
        }

        switch result {
        case .success(let map):
          if let map = map {
            maps.append(map)
          } else {
            return completion(nil, .mapNotExist)
          }

        case .failure(let error):
          return completion(nil, .error(error.localizedDescription))
        }
      }
      return completion(maps, nil)
    }
  }
}
