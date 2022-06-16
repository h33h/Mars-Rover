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

enum EditMapAction {
  case clearMapNodes
  case generateRandomMap
  case replaceMapBlock(replacingNode: SCNBlockNode, block: Obstacle)
}

protocol MapCreatorProtocol {
  var currentMap: RealmMap { get }
  var mapType: MapType { get }
  var mapNode: SCNNode { get }
  func mapModel(action: EditMapAction)
  func node(rowIndex: Int, colomnIndex: Int) -> SCNBlockNode?
}

class MapCreator: MapCreatorProtocol {
  private(set) var currentMap: RealmMap
  private(set) var mapType: MapType
  private(set) var mapNode: SCNNode

  init(size: MapSize) {
    self.mapNode = SCNNode()
    self.currentMap = RealmMap()
    let mapModel = RealmMapContent(size: size)
    self.currentMap.mapContent = mapModel
    self.mapType = .new
    self.createMap()
  }

  init?(mapModelData: RealmMap) {
    self.mapNode = SCNNode()
    self.currentMap = RealmMap(value: mapModelData)
    self.mapType = .existed
    self.createMap()
  }

  func node(rowIndex: Int, colomnIndex: Int) -> SCNBlockNode? {
    guard let mapModelDimension = currentMap.mapContent?.getMapSize().getSize() else { return nil }
    if rowIndex >= 0, colomnIndex >= 0, rowIndex <= mapModelDimension.rows, colomnIndex <= mapModelDimension.colomns {
      return mapNode.childNodes[rowIndex * mapModelDimension.colomns + colomnIndex] as? SCNBlockNode
    }
    return nil
  }

  func mapModel(action: EditMapAction) {
    switch action {
    case .clearMapNodes:
      clearMapNodes()
    case let .replaceMapBlock(replacingNode, block):
      replaceMapBlock(replacingNode: replacingNode, with: block)
    case .generateRandomMap:
      generateRandomMap()
    }
  }

  private func updateMapModelData() {
    guard let mapModel = currentMap.mapContent else { return }
    var newMap: [Int] = []
    for row in 0 ..< mapModel.getMapSize().getSize().rows {
      for colomn in 0 ..< mapModel.getMapSize().getSize().colomns {
        guard
          let node = node(rowIndex: row, colomnIndex: colomn)
        else { return }
        newMap.append(node.obstacle.rawValue)
      }
    }
    currentMap.lastEdited = Date()
    currentMap.mapContent = RealmMapContent(size: mapModel.getMapSize(), map: newMap)
  }

  private func clearMapNodes() {
    mapNode.enumerateChildNodes { node, _ in
      node.removeFromParentNode()
    }
  }

  private func createMap() {
    guard let mapModel = currentMap.mapContent else { return }
    clearMapNodes()
    for row in 0 ..< mapModel.getMapSize().getSize().rows {
      for colomn in 0 ..< mapModel.getMapSize().getSize().colomns {
        if let obstacle = mapModel[row, colomn] {
          let block = SCNBlockNode(positionOnMap: MatrixPoint(row: row, colomn: colomn), obstacle: obstacle)
          mapNode.addChildNode(block)
        } else {
          let block = SCNBlockNode(positionOnMap: MatrixPoint(row: row, colomn: colomn), obstacle: Obstacle.solidGround)
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
        replacingNode.positionOnMap != currentMap.mapContent?.startGamePoint(),
        replacingNode.positionOnMap != currentMap.mapContent?.endGamePoint()
      {
        let block = SCNBlockNode(positionOnMap: replacingNode.positionOnMap, obstacle: obstacle)
        mapNode.replaceChildNode(replacingNode, with: block)
      }
    }
    updateMapModelData()
  }

  private func generateRandomMap() {
    mapNode.enumerateChildNodes { blockNode, _ in
      if
        let blockNode = blockNode as? SCNBlockNode,
        let obstacle = Obstacle(
          rawValue: Int.random(in: 0 ..< Obstacle.allCases.count)),
        blockNode.positionOnMap != currentMap.mapContent?.startGamePoint(),
        blockNode.positionOnMap != currentMap.mapContent?.endGamePoint()
      {
        let block = SCNBlockNode(positionOnMap: blockNode.positionOnMap, obstacle: obstacle)
        mapNode.replaceChildNode(blockNode, with: block)
      }
    }
    updateMapModelData()
  }

  deinit {
    mapNode.removeFromParentNode()
  }
}
