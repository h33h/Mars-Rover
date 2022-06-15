//
//  MapModel.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import RealmSwift

class RealmMapModelData: Object {
// MARK: - RealmMapModelData: Variables
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var mapLabel: String
  @Persisted var lastEdited: Date
  @Persisted var map: RealmMapModel?

// MARK: - RealmMapModelData: Init Methods
  convenience init(mapLabel: String, lastEdited: Date, map: RealmMapModel) {
    self.init()
    self.mapLabel = mapLabel
    self.lastEdited = lastEdited
    self.map = map
  }
}

extension RealmMapModelData {
// MARK: - RealmMapModelData: Methods
  func convertToFirebaseMapModelData() -> FirebaseMapModelData? {
    guard let map = self.map else { return nil }
    return FirebaseMapModelData(
      id: self.id.stringValue,
      mapLabel: self.mapLabel,
      lastEdited: self.lastEdited,
      map: map.convertToFirebaseMapModel()
    )
  }
}
