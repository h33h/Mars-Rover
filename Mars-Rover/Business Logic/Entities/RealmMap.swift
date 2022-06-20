//
//  RealmMap.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import RealmSwift

class RealmMap: Object {
  @Persisted(primaryKey: true) private(set) var id: ObjectId
  @Persisted var label: String
  @Persisted var lastEdited: Date
  // swiftlint:disable implicitly_unwrapped_optional
  @Persisted var mapContent: RealmMapContent! {
    didSet { lastEdited = Date() }
  }

  convenience init(
    id: ObjectId,
    label: String,
    lastEdited: Date,
    mapContent: RealmMapContent
  ) {
    self.init()
    self.id = id
    self.label = label
    self.lastEdited = lastEdited
    self.mapContent = mapContent
  }
}

extension RealmMap {
  func convertToFirebaseMap() -> FirebaseMap {
    FirebaseMap(
      id: self.id.stringValue,
      label: self.label,
      lastEdited: self.lastEdited,
      mapContent: self.mapContent.convertToFirebaseMapContent()
    )
  }
}

extension RealmMap: NSCopying {
  func copy(with zone: NSZone? = nil) -> Any {
    // swiftlint:disable force_cast
    RealmMap(id: id, label: label, lastEdited: lastEdited, mapContent: mapContent.copy() as! RealmMapContent)
  }
}
