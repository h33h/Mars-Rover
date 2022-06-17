//
//  MapSize.swift
//  Mars Rover
//
//  Created by XXX on 23.11.21.
//

import RealmSwift

class MapSize: Object, Codable {
  enum CodingKeys: String, CodingKey {
    case rows
    case colomns
  }

  @Persisted dynamic var rows: Int
  @Persisted dynamic var colomns: Int

  var startPoint: MatrixPoint {
    MatrixPoint(row: rows / 2, colomn: .zero)
  }

  var endPoint: MatrixPoint {
    MatrixPoint(row: rows / 2, colomn: colomns - 1)
  }

  override init() {
    super.init()
    self.rows = 9
    self.colomns = 16
  }

  init(rows: Int, colomns: Int) {
    self.rows = rows
    self.colomns = colomns
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    rows = try container.decode(Int.self, forKey: .rows)
    colomns = try container.decode(Int.self, forKey: .colomns)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(rows, forKey: .rows)
    try container.encode(colomns, forKey: .colomns)
  }

  func isPointInBounds(_ point: MatrixPoint) -> Bool {
    if
      point.row >= 0,
      point.colomn >= 0,
      point.row <= rows,
      point.colomn <= colomns {
      return true
    } else {
      return false
    }
  }
}
