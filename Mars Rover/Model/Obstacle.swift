//
//  Obstacle.swift
//  Mars Rover
//
//  Created by XXX on 13.11.21.
//

import Foundation
import SceneKit

enum Obstacle: Int, CaseIterable {
  case solidGround = 0
  case sand
  case pit
  case hill

  func getBlock() -> SCNNode? {
    switch self {
    case .solidGround:
      return SCNScene(named: "GameAssets.scnassets/solidBlock.scn")?.rootNode.childNode(withName: "Cube", recursively: true)
    case .sand:
      return SCNScene(named: "GameAssets.scnassets/sandBlock.scn")?.rootNode.childNode(withName: "Cube", recursively: true)
    case .pit:
      return SCNScene(named: "GameAssets.scnassets/blockWithHole.scn")?.rootNode.childNode(withName: "Cube", recursively: true)
    case .hill:
      return SCNScene(named: "GameAssets.scnassets/blockWithHill.scn")?.rootNode.childNode(withName: "Cube", recursively: true)
    }
  }

  static func getObstacle(node: SCNNode) -> Obstacle? {
    if node.name == "solidBlock" { return .solidGround }
    if node.name == "sandBlock" { return .sand }
    if node.name == "blockWithHole" { return .pit }
    if node.name == "blockWithHill" { return .hill }
    return nil
  }
}
