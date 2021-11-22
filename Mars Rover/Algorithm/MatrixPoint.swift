//
//  MatrixPoint.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

import Foundation

struct MatrixPoint {
  let row: Int
  let colomn: Int

  func toString() -> String {
    "\(self.row) \(self.colomn)"
  }
}
