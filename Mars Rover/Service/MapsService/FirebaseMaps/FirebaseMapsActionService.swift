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
  func mapAction(is action: FirebaseMapAction)
}

class FirebaseMapsActionService: FirebaseMapsActionServiceProtocol {
  func mapAction(is action: FirebaseMapAction) {
    switch action {
    case .addMap(let firebaseMapModelData):
      try? addMap(map: firebaseMapModelData)
    case .editMap(let firebaseMapModelData):
      try? editMap(map: firebaseMapModelData)
    case .removeMap(let mapId):
      try? removeMap(withId: mapId)
    }
  }

  private func addMap(map: FirebaseMapModelData) throws {
    guard let user = Auth.auth().currentUser else { throw FirebaseMapsServceError.notSignedIn }
    do {
      try  Firestore.firestore().collection("users").document(user.uid).collection("maps").document(map.id).setData(from: map)
    } catch {
      throw FirebaseMapsServceError.textError(description: error.localizedDescription)
    }
  }

  private func editMap(map: FirebaseMapModelData) throws {
    guard let user = Auth.auth().currentUser else { throw FirebaseMapsServceError.notSignedIn }
    let mapRef = Firestore.firestore().collection("users").document(user.uid).collection("maps").document(map.id)
    mapRef.updateData(
      [
        "mapLabel": map.mapLabel,
        "lastEdited": map.lastEdited,
        "map": map.map
      ]
    )
  }

  private func removeMap(withId mapId: String) throws {
    guard let user = Auth.auth().currentUser else { throw FirebaseMapsServceError.notSignedIn }
    Firestore.firestore().collection("users").document(user.uid).collection("maps").document(mapId).delete()
  }
}
