//
//  MapSize.swift
//  Mars Rover
//
//  Created by XXX on 23.11.21.
//

import Foundation

enum MapSize {
  case defaultSize
  case mapSize(rows: Int, colomns: Int)

  func getSize() -> (rows: Int, colomns: Int) {
    switch self {
    case .defaultSize:
      return (rows: 9, colomns: 16)
    case let .mapSize(rows, colomns):
      return (rows: rows, colomns: colomns)
    }
  }
}
