//
//  MapManager.swift
//  Mars Rover
//
//  Created by XXX on 19.11.21.
//

import SceneKit

enum MapType {
  case new
  case existed
}

enum MapManagerAction {
  case clear
  case generateRandomMap
  case replaceBlock(replacingNode: SCNBlockNode, block: Obstacle)
}

protocol MapManagerProtocol {
  var mapContent: RealmMapContent { get }
  var mapNode: SCNNode { get }
  func manager(action: MapManagerAction)
  func node(in point: MatrixPoint) -> SCNBlockNode?
}

class MapManager: MapManagerProtocol {
  private(set) lazy var mapNode = SCNNode()
  private(set) var mapContent: RealmMapContent

  init(mapContent: RealmMapContent) {
    self.mapContent = mapContent
    self.createMap()
  }

  func node(in point: MatrixPoint) -> SCNBlockNode? {
    if mapContent.size.isPointInBounds(point) {
      return mapNode
        .childNodes[
          point.row * mapContent.size.colomns + point.colomn
        ] as? SCNBlockNode
    }
    return nil
  }

  func manager(action: MapManagerAction) {
    switch action {
    case .clear:
      removeMapBlocks()
    case let .replaceBlock(replacingNode, block):
      replaceMapBlock(
        replacingNode: replacingNode,
        with: block
      )
    case .generateRandomMap:
      generateRandomMap()
    }
  }

  private func updateMapContent() {
    for row in .zero ..< mapContent.size.rows {
      for colomn in .zero ..< mapContent.size.colomns {

        let point = MatrixPoint(row: row, colomn: colomn)
        guard
          let node = node(in: point),
          let mapObstacle = mapContent[point],
          mapObstacle != node.obstacle
        else { continue }
        mapContent[point] = node.obstacle
      }
    }
  }

  private func removeMapBlocks() {
    mapNode.enumerateChildNodes { node, _ in
      node.removeFromParentNode()
    }
  }

  private func createMap() {
    removeMapBlocks()
    for row in .zero ..< mapContent.size.rows {
      for colomn in .zero ..< mapContent.size.colomns {

        if let obstacle = mapContent[MatrixPoint(row: row, colomn: colomn)] {

          let block = SCNBlockNode(
            positionOnMap: MatrixPoint(row: row, colomn: colomn),
            obstacle: obstacle
          )
          mapNode.addChildNode(block)
        }
      }
    }
  }

  private func replaceMapBlock(replacingNode: SCNBlockNode, with obstacle: Obstacle) {
    mapNode.enumerateChildNodes { blockNode, _ in

      if
        replacingNode == blockNode,
        replacingNode.obstacle != obstacle,
        replacingNode.positionOnMap != mapContent.size.startPoint,
        replacingNode.positionOnMap != mapContent.size.endPoint
      {

        let block = SCNBlockNode(positionOnMap: replacingNode.positionOnMap, obstacle: obstacle)
        mapNode.replaceChildNode(replacingNode, with: block)
      }
    }
    updateMapContent()
  }

  private func generateRandomMap() {
    mapNode.enumerateChildNodes { blockNode, _ in

      if
        let blockNode = blockNode as? SCNBlockNode,
        let obstacle = Obstacle(
          rawValue: Int.random(
            in: .zero ..< Obstacle.allCases.count
          )
        ),
        blockNode.positionOnMap != mapContent.size.startPoint,
        blockNode.positionOnMap != mapContent.size.endPoint
      {

        let block = SCNBlockNode(positionOnMap: blockNode.positionOnMap, obstacle: obstacle)
        mapNode.replaceChildNode(blockNode, with: block)
      }
    }
    updateMapContent()
  }

  deinit {
    mapNode.removeFromParentNode()
  }
}
