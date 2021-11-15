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

// MARK: - FirebaseMapModel: Subscript
  subscript(rowIndex: Int, colomnIndex: Int) -> Obstacle? {
    get {
      if rowIndex >= 0, colomnIndex >= 0, rowIndex <= rowCount, colomnIndex <= colomnsCount {
        return rowIndex == 0 ? Obstacle(rawValue: map[colomnIndex]) : Obstacle(rawValue: map[rowIndex * colomnIndex])
      }
      return nil
    }
    set {
      guard let newValue = newValue, newValue.rawValue >= 0, newValue.rawValue < Obstacle.allCases.count else { return }
      if rowIndex >= 0, colomnIndex >= 0, rowIndex <= rowCount, colomnIndex <= colomnsCount {
        rowIndex == 0 ? (map[colomnIndex] = newValue.rawValue) : (map[rowIndex * colomnIndex] = newValue.rawValue)
      }
    }
  }
}

extension FirebaseMapModel {
// MARK: - FirebaseMapModel: Methods
  func convertToRealmMapModel() -> RealmMapModel {
    let realmMapModel = RealmMapModel(rowCount: self.rowCount, colomnsCount: self.colomnsCount)
    realmMapModel.map.removeAll()
    realmMapModel.map.append(objectsIn: self.map)
    return realmMapModel
  }
}