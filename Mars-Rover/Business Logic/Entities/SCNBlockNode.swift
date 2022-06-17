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

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError()
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
        named: L10n.Entities.SCNBlockNode.SolidGround.path
      )?.rootNode.childNodes.first?.childNodes.first?.geometry
    case .sand:
      geometry = SCNScene(
        named: L10n.Entities.SCNBlockNode.Sand.path
      )?.rootNode.childNodes.first?.childNodes.first?.geometry
    case .pit:
      geometry = SCNScene(
        named: L10n.Entities.SCNBlockNode.Pit.path
      )?.rootNode.childNodes.first?.childNodes.first?.geometry
    case .hill:
      geometry = SCNScene(
        named: L10n.Entities.SCNBlockNode.Hill.path
      )?.rootNode.childNodes.first?.childNodes.first?.geometry
    }
  }
}
