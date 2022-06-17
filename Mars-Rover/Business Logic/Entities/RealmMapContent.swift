//
//  RealmMapContent.swift
//  Mars Rover
//
//  Created by XXX on 11.11.21.
//

import RealmSwift

class RealmMapContent: Object {
  // swiftlint:disable implicitly_unwrapped_optional
  @Persisted private(set) var size: MapSize!
  @Persisted private(set) var map: List<Int>

  convenience init(size: MapSize) {
    self.init()
    self.size = size
    self.map = List<Int>()
    map.append(objectsIn: Array(repeating: .zero, count: (size.rows * size.colomns)))
  }

  convenience init(size: MapSize, map: [Int]) {
    self.init(size: size)
    self.map.replaceSubrange(.zero..<map.count, with: map)
  }

  subscript(point: MatrixPoint) -> Obstacle? {
    get {
      if size.isPointInBounds(point) {
        return Obstacle(rawValue: map[point.row * size.colomns + point.colomn])
      }
      return nil
    }
    set {
      guard
        let newValue = newValue,
        size.isPointInBounds(point)
      else { return }
      map[point.row * size.colomns + point.colomn] = newValue.rawValue
    }
  }
}

extension RealmMapContent {
  func convertToFirebaseMapContent() -> FirebaseMapContent {
    FirebaseMapContent(size: size, map: Array(self.map))
  }
}

extension RealmMapContent: NSCopying {
  func copy(with zone: NSZone? = nil) -> Any {
    RealmMapContent(size: size, map: Array(map))
  }
}
