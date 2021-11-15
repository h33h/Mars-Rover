//
//  MapModel.swift
//  Mars Rover
//
//  Created by XXX on 11.11.21.
//

import Foundation
import RealmSwift

class RealmMapModel: Object {
// MARK: - RealmMapModel: Variables
  @Persisted private var rowCount: Int
  @Persisted private var colomnsCount: Int
  @Persisted var map: List<Int>

// MARK: - RealmMapModel: Init Methods
  convenience init(rowCount: Int, colomnsCount: Int) {
    self.init()
    self.rowCount = rowCount
    self.colomnsCount = colomnsCount
    self.map = List<Int>()
    map.append(objectsIn: Array(repeating: 0, count: (rowCount * colomnsCount)))
  }

// MARK: - RealmMapModel: Subscript
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

extension RealmMapModel {
// MARK: - RealmMapModel: Methods
  func convertToFirebaseMapModel() -> FirebaseMapModel {
    return FirebaseMapModel(rowCount: self.rowCount, colomnsCount: self.colomnsCount, map: Array(self.map))
  }
}
