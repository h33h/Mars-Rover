//
//  FirebaseMapModel.swift
//  Mars Rover
//
//  Created by XXX on 13.11.21.
//

import Foundation

struct FirebaseMapContent: Codable {
// MARK: - FirebaseMapContent: Variables
  var rowCount: Int
  var colomnsCount: Int
  var map: [Int]
}

extension FirebaseMapContent {
// MARK: - FirebaseMapContent: Methods
  func convertToRealmMapContent() -> RealmMapContent {
    let realmMapModel = RealmMapContent(size: .mapSize(rows: self.rowCount, colomns: self.colomnsCount))
    realmMapModel.map.removeAll()
    realmMapModel.map.append(objectsIn: self.map)
    return realmMapModel
  }
}
