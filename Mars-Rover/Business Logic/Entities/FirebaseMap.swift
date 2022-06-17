//
//  FirebaseMap.swift
//  Mars Rover
//
//  Created by XXX on 12.11.21.
//

import RealmSwift

struct FirebaseMap: Codable {
  private(set) var id: String
  private(set) var label: String
  private(set) var lastEdited: Date
  private(set) var mapContent: FirebaseMapContent
}

extension FirebaseMap {
  func convertToRealmMap() -> RealmMap {
    // swiftlint:disable force_try
    RealmMap(
      id: try! ObjectId(string: id),
      label: label,
      lastEdited: lastEdited,
      mapContent: mapContent.convertToRealmMapContent()
    )
  }
}
