//
//  Obstacle.swift
//  Mars Rover
//
//  Created by XXX on 13.11.21.
//

import SceneKit

enum Obstacle: Int, CaseIterable {
  case solidGround = 0
  case hill
  case sand
  case pit
}

extension Obstacle {
  func toString() -> String {
    switch self {
    case .solidGround:
      return "Solid Ground"
    case .sand:
      return "Sand"
    case .pit:
      return "Hole"
    case .hill:
      return "Hill"
    }
  }
}
