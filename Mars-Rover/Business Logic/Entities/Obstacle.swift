//
//  Obstacle.swift
//  Mars Rover
//
//  Created by XXX on 13.11.21.
//

enum Obstacle: Int, CaseIterable {
  case solidGround, hill, sand, pit
}

extension Obstacle {
  var title: String {
    switch self {
    case .solidGround: return L10n.Entities.Obstacle.solidGround
    case .sand: return L10n.Entities.Obstacle.sand
    case .pit: return L10n.Entities.Obstacle.pit
    case .hill: return L10n.Entities.Obstacle.hill
    }
  }
}
