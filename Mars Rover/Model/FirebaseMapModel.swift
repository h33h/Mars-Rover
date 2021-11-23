//
//  FirebaseMapModel.swift
//  Mars Rover
//
//  Created by XXX on 13.11.21.
//

import Foundation

struct FirebaseMapModel: Codable {
// MARK: - FirebaseMapModel: Variables
  var rowCount: Int
  var colomnsCount: Int
  var map: [Int]
}

extension FirebaseMapModel {
// MARK: - FirebaseMapModel: Methods
  func convertToRealmMapModel() -> RealmMapModel {
    let realmMapModel = RealmMapModel(size: .mapSize(rows: self.rowCount, colomns: self.colomnsCount))
    realmMapModel.map.removeAll()
    realmMapModel.map.append(objectsIn: self.map)
    return realmMapModel
  }
}
