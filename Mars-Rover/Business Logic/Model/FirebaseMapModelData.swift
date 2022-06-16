//
//  FirebaseMap.swift
//  Mars Rover
//
//  Created by XXX on 12.11.21.
//

import RealmSwift

struct FirebaseMap: Codable {
// MARK: - FirebaseMap: Variables
  var id: String
  var mapLabel: String
  var lastEdited: Date
  var mapContent: FirebaseMapContent
}

extension FirebaseMap {
// MARK: - FirebaseMap: Methods
  func convertToRealmMap() -> RealmMap? {
    guard let id = try? ObjectId(string: self.id)  else { return nil }
    let realmMap = RealmMap()
    realmMap.id = id
    realmMap.mapLabel = self.mapLabel
    realmMap.lastEdited = self.lastEdited
    realmMap.mapContent = self.mapContent.convertToRealmMapContent()
    return realmMap
  }
}
