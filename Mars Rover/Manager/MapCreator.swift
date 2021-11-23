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
  case replaceMapBlock(replacingNode: SCNNode, block: Obstacle)
}

protocol MapCreatorProtocol {
  var currentMap: RealmMapModelData { get }
  var mapType: MapType { get }
  var mapNode: SCNNode { get }
  func mapModel(action: EditMapAction)
}

class MapCreator: MapCreatorProtocol {
  private(set) var currentMap: RealmMapModelData
  private(set) var mapType: MapType
  private(set) var mapNode: SCNNode

  init(size: MapSize) {
    self.mapNode = SCNNode()
    self.currentMap = RealmMapModelData()
    let mapModel = RealmMapModel(size: size)
    self.currentMap.map = mapModel
    self.mapType = .new
    self.createMap()
  }

  init?(mapModelData: RealmMapModelData) {
    self.mapNode = SCNNode()
    self.currentMap = RealmMapModelData(value: mapModelData)
    self.mapType = .existed
    self.createMap()
  }

  func node(rowIndex: Int, colomnIndex: Int) -> SCNNode? {
    guard let mapModelDimension = currentMap.map?.getMapSize().getSize() else { return nil }
    if rowIndex >= 0, colomnIndex >= 0, rowIndex <= mapModelDimension.rows, colomnIndex <= mapModelDimension.colomns {
      return mapNode.childNodes[rowIndex * mapModelDimension.colomns + colomnIndex]
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
    guard let mapModel = currentMap.map else { return }
    var newMap: [Int] = []
    for row in 0 ..< mapModel.getMapSize().getSize().rows {
      for colomn in 0 ..< mapModel.getMapSize().getSize().colomns {
        guard
          let node = node(rowIndex: row, colomnIndex: colomn)?.childNodes.first,
          let obstacle = Obstacle.getObstacle(node: node)
        else { return }
        newMap.append(obstacle.rawValue)
      }
    }
    currentMap.lastEdited = Date()
    currentMap.map = RealmMapModel(size: mapModel.getMapSize(), map: newMap)
  }

  private func clearMapNodes() {
    mapNode.enumerateChildNodes { node, _ in
      node.removeFromParentNode()
    }
  }

  private func createMap() {
    guard let mapModel = currentMap.map else { return }
    clearMapNodes()
    for row in 0 ..< mapModel.getMapSize().getSize().rows {
      for colomn in 0 ..< mapModel.getMapSize().getSize().colomns {
        let block = SCNNode()
        block.name = "\(row) \(colomn)"
        block.position = SCNVector3(x: Float(22 * colomn), y: 14, z: Float(22 * row))
        if let blockModel = mapModel[row, colomn]?.getBlock()?.flattenedClone() {
          block.addChildNode(blockModel)
        } else {
          guard let solidGroundBlock = Obstacle.solidGround.getBlock()?.flattenedClone() else { return }
          block.addChildNode(solidGroundBlock)
        }
        mapNode.addChildNode(block)
      }
    }
  }

  private func replaceMapBlock(replacingNode: SCNNode, with block: Obstacle) {
    guard let block = block.getBlock()?.flattenedClone() else { return }
    mapNode.enumerateChildNodes { containerNode, _ in
      if
        let blockInBlockContainer = containerNode.childNodes.first,
        replacingNode == blockInBlockContainer
      {
        let position = blockInBlockContainer.position
        blockInBlockContainer.removeFromParentNode()
        block.position = position
        containerNode.addChildNode(block)
      }
    }
    updateMapModelData()
  }

  private func generateRandomMap() {
    mapNode.enumerateChildNodes { containerNode, _ in
      if
        let blockInBlockContainer = containerNode.childNodes.first,
        let block = Obstacle.init(rawValue: Int.random(in: 0 ..< Obstacle.allCases.count))?.getBlock()?.flattenedClone()
      {
        let position = blockInBlockContainer.position
        blockInBlockContainer.removeFromParentNode()
        block.position = position
        containerNode.addChildNode(block)
      }
    }
    updateMapModelData()
  }

  deinit {
    mapNode.removeFromParentNode()
  }
}
