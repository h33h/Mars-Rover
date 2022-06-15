//
//  MapModel.swift
//  Mars Rover
//
//  Created by XXX on 11.11.21.
//

import RealmSwift

class RealmMapModel: Object {
// MARK: - RealmMapModel: Variables
  @Persisted private var rowCount: Int
  @Persisted private var colomnsCount: Int
  @Persisted var map: List<Int>

// MARK: - RealmMapModel: Init Methods
  convenience init(size: MapSize) {
    self.init()
    self.rowCount = size.getSize().rows
    self.colomnsCount = size.getSize().colomns
    self.map = List<Int>()
    map.append(objectsIn: Array(repeating: 0, count: (rowCount * colomnsCount)))
  }

  convenience init(size: MapSize, map: [Int]) {
    self.init()
    self.rowCount = size.getSize().rows
    self.colomnsCount = size.getSize().colomns
    self.map = List<Int>()
    map.forEach { self.map.append($0) }
  }

// MARK: - RealmMapModel: Subscript
  subscript(rowIndex: Int, colomnIndex: Int) -> Obstacle? {
    get {
      if rowIndex >= 0, colomnIndex >= 0, rowIndex <= rowCount, colomnIndex <= colomnsCount {
        return Obstacle(rawValue: map[rowIndex * colomnsCount + colomnIndex])
      }
      return nil
    }
    set {
      guard let newValue = newValue, newValue.rawValue >= 0, newValue.rawValue < Obstacle.allCases.count else { return }
      if rowIndex >= 0, colomnIndex >= 0, rowIndex <= rowCount, colomnIndex <= colomnsCount {
        map[rowIndex * colomnsCount + colomnIndex] = newValue.rawValue
      }
    }
  }
}

extension RealmMapModel {
// MARK: - RealmMapModel: Methods
  func convertToFirebaseMapModel() -> FirebaseMapModel {
    FirebaseMapModel(rowCount: self.rowCount, colomnsCount: self.colomnsCount, map: Array(self.map))
  }

  func getMapSize() -> MapSize {
    .mapSize(rows: self.rowCount, colomns: self.colomnsCount)
  }

  func startGamePoint() -> MatrixPoint {
    MatrixPoint(row: Int((getMapSize().getSize().rows - 1) / 2), colomn: 0)
  }

  func endGamePoint() -> MatrixPoint {
    MatrixPoint(row: Int((getMapSize().getSize().rows - 1) / 2), colomn: getMapSize().getSize().colomns - 1)
  }
}
