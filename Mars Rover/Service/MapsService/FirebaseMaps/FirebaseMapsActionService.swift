//
//  FirebaseMapsActionService.swift
//  Mars Rover
//
//  Created by XXX on 14.11.21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum FirebaseMapAction {
  case addMap(FirebaseMapModelData)
  case editMap(FirebaseMapModelData)
  case removeMap(String)
}

protocol FirebaseMapsActionServiceProtocol {
  func mapAction(is action: FirebaseMapAction, errorHandler: @escaping FirebaseMapsServceErrorCompletion)
}

class FirebaseMapsActionService: FirebaseMapsActionServiceProtocol {
  func mapAction(is action: FirebaseMapAction, errorHandler: @escaping FirebaseMapsServceErrorCompletion) {
    switch action {
    case .addMap(let firebaseMapModelData):
      addMap(map: firebaseMapModelData) { return errorHandler($0) }
    case .editMap(let firebaseMapModelData):
      editMap(map: firebaseMapModelData) { return errorHandler($0) }
    case .removeMap(let mapId):
      removeMap(withId: mapId) { return errorHandler($0) }
    }
  }

  private func addMap(map: FirebaseMapModelData, errorHandler: @escaping FirebaseMapsServceErrorCompletion) {
    guard let user = Auth.auth().currentUser else { return errorHandler(.notSignedIn) }
    do {
      try  Firestore.firestore().collection("users").document(user.uid).collection("maps").document(map.id).setData(from: map)
    } catch {
      return errorHandler(.textError(description: error.localizedDescription))
    }
  }

  private func editMap(map: FirebaseMapModelData, errorHandler: @escaping FirebaseMapsServceErrorCompletion) {
    guard let user = Auth.auth().currentUser else { return errorHandler(.notSignedIn) }
    let mapRef = Firestore.firestore().collection("users").document(user.uid).collection("maps").document(map.id)
    mapRef.updateData(
      [
        "mapLabel": map.mapLabel,
        "lastEdited": map.lastEdited,
        "map": map.map
      ]
    ) { error in
      if let error = error {
        return errorHandler(.textError(description: error.localizedDescription))
      }
    }
  }

  private func removeMap(withId mapId: String, errorHandler: @escaping FirebaseMapsServceErrorCompletion) {
    guard let user = Auth.auth().currentUser else { return errorHandler(.notSignedIn) }
    Firestore.firestore().collection("users").document(user.uid).collection("maps").document(mapId).delete { error in
      if let error = error {
        return errorHandler(.textError(description: error.localizedDescription))
      }
    }
  }
}
