//
//  SCNBlockNode.swift
//  Mars Rover
//
//  Created by XXX on 24.11.21.
//

import SceneKit

class SCNBlockNode: SCNNode {
  var positionOnMap: MatrixPoint
  var obstacle: Obstacle

  init(positionOnMap: MatrixPoint, obstacle: Obstacle) {
    self.positionOnMap = positionOnMap
    self.obstacle = obstacle
    super.init()
    self.setGeometryOfBlock(obstacle: obstacle)
    self.setPosition()
  }

  required init?(coder: NSCoder) {
    fatalError("Error")
  }

  private func setPosition() {
    position = SCNVector3(
      x: getBlockSize().x * Float(positionOnMap.colomn),
      y: getBlockSize().y / 2,
      z: getBlockSize().z * Float(positionOnMap.row)
    )
  }

  private func setGeometryOfBlock(obstacle: Obstacle) {
    switch obstacle {
    case .solidGround:
      geometry = SCNScene(
        named: "art.scnassets/solidBlock.scn")?.rootNode.childNodes.first?.childNodes.first?.geometry
    case .sand:
      geometry = SCNScene(
        named: "art.scnassets/sandBlock.scn")?.rootNode.childNodes.first?.childNodes.first?.geometry
    case .pit:
      geometry = SCNScene(
        named: "art.scnassets/blockWithHole.scn")?.rootNode.childNodes.first?.childNodes.first?.geometry
    case .hill:
      geometry = SCNScene(
        named: "art.scnassets/blockWithHill.scn")?.rootNode.childNodes.first?.childNodes.first?.geometry
    }
  }
}
