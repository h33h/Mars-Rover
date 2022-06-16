//
//  FirebaseMapsActionService.swift
//  Mars Rover
//
//  Created by XXX on 14.11.21.
//

import FirebaseAuth
import FirebaseFirestore

final class FirebaseMapsActionService: FirebaseMapsActionServiceProtocol {
  func mapAction(
    is action: FirebaseMapAction,
    errorHandler: @escaping FirebaseMapActionCompletion
  ) {
    switch action {
    case .add(let map): add(map: map) { errorHandler($0) }
    case .edit(let map): edit(map: map) { errorHandler($0) }
    case .remove(let map): remove(map: map) { errorHandler($0) }
    }
  }

  private func add(
    map: FirebaseMap,
    errorHandler: @escaping FirebaseMapActionCompletion
  ) {
    guard
      let user = Auth.auth().currentUser
    else { return errorHandler(.notSignedIn) }

    do {
      try Firestore
        .firestore()
        .collection("users")
        .document(user.uid)
        .collection("maps")
        .document(map.id)
        .setData(from: map)
    } catch {
      return errorHandler(.error(error.localizedDescription))
    }
  }

  private func edit(
    map: FirebaseMap,
    errorHandler: @escaping FirebaseMapActionCompletion
  ) {
    guard
      let user = Auth.auth().currentUser
    else { return errorHandler(.notSignedIn) }

    let mapRef = Firestore
      .firestore()
      .collection("users")
      .document(user.uid)
      .collection("maps")
      .document(map.id)

    mapRef.updateData(
      [
        "mapLabel": map.mapLabel,
        "lastEdited": map.lastEdited,
        "mapContent": [
          "colomnsCount": map.mapContent.colomnsCount,
          "rowCount": map.mapContent.rowCount,
          "map": map.mapContent.map
        ]
      ]
    ) { error in
      if let error = error {
        return errorHandler(.error(error.localizedDescription))
      }
    }
  }

  private func remove(
    map: FirebaseMap,
    errorHandler: @escaping FirebaseMapActionCompletion
  ) {
    guard
      let user = Auth.auth().currentUser
    else { return errorHandler(.notSignedIn) }

    Firestore
      .firestore()
      .collection("users")
      .document(user.uid)
      .collection("maps")
      .document(map.id)
      .delete { error in
        if let error = error {
          return errorHandler(.error(error.localizedDescription))
        }
      }
  }
}
