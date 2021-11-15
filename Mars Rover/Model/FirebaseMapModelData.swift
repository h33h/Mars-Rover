//
//  FirebaseMapModel.swift
//  Mars Rover
//
//  Created by XXX on 12.11.21.
//

import Foundation
import RealmSwift

struct FirebaseMapModelData: Codable {
// MARK: - FirebaseMapModelData: Variables
  var id: String
  var mapLabel: String
  var lastEdited: Date
  var map: FirebaseMapModel
}

extension FirebaseMapModelData {
// MARK: - FirebaseMapModelData: Methods
  func convertToRealmMapModelData() -> RealmMapModelData? {
    guard let id = try? ObjectId.init(string: self.id)  else { return nil }
    let realmMapModelData = RealmMapModelData()
    realmMapModelData.id = id
    realmMapModelData.mapLabel = self.mapLabel
    realmMapModelData.lastEdited = self.lastEdited
    realmMapModelData.map = self.map.convertToRealmMapModel()
    return realmMapModelData
  }
}
