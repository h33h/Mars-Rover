//
//  RealmMap.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import RealmSwift

class RealmMap: Object {
// MARK: - RealmMap: Variables
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var mapLabel: String
  @Persisted var lastEdited: Date
  @Persisted var mapContent: RealmMapContent?

// MARK: - RealmMap: Init Methods
  convenience init(mapLabel: String, lastEdited: Date, mapContent: RealmMapContent) {
    self.init()
    self.mapLabel = mapLabel
    self.lastEdited = lastEdited
    self.mapContent = mapContent
  }
}

extension RealmMap {
// MARK: - RealmMap: Methods
  func convertToFirebaseMap() -> FirebaseMap? {
    guard let map = self.mapContent else { return nil }
    return FirebaseMap(
      id: self.id.stringValue,
      mapLabel: self.mapLabel,
      lastEdited: self.lastEdited,
      mapContent: map.convertToFirebaseMapContent()
    )
  }
}
