//
//  MapManager.swift
//  Mars Rover
//
//  Created by XXX on 19.11.21.
//

import SceneKit

enum MapBoardCreateType {
  case newMap
  case fromMap(map: RealmMapModelData)
}

enum MapBoardActionType {
  case clear
  case generateRandomMap
  case replaceMapBlock(replacingNode: SCNNode, block: Obstacle)
}

protocol MapManagerProtocol {
  func createMapBoard(type: MapBoardCreateType)
  func mapAction(action: MapBoardActionType)
  func getMapModelData() -> RealmMapModelData?
  func getMapNode() -> SCNNode
}

class MapManager: MapManagerProtocol {
  private var currentMap: RealmMapModelData?
  private let startZ: Float = -90.0
  private let startX: Float = -170.0
  private let rowsCount: Int
  private let colomnsCount: Int
  private let startPoint: MatrixPoint
  private let endPoint: MatrixPoint
  private var mapNode: SCNNode

  init(rowsCount: Int, colomnsCount: Int) {
    self.rowsCount = rowsCount
    self.colomnsCount = colomnsCount
    self.startPoint = MatrixPoint(row: rowsCount / 2, colomn: 0)
    self.endPoint = MatrixPoint(row: rowsCount / 2, colomn: colomnsCount - 1)
    self.mapNode = SCNNode()
    self.currentMap = RealmMapModelData(
      mapLabel: "",
      lastEdited: Date(),
      map: RealmMapModel(rowCount: rowsCount, colomnsCount: colomnsCount)
    )
    self.createMapBoard(type: .newMap)
  }

  init?(mapModelData: RealmMapModelData) {
    guard
      let rows = mapModelData.map?.getMapSize().rows,
      let colomns = mapModelData.map?.getMapSize().colomns
    else { return nil }
    self.rowsCount = rows
    self.colomnsCount = colomns
    self.startPoint = MatrixPoint(row: rowsCount / 2, colomn: 0)
    self.endPoint = MatrixPoint(row: rowsCount / 2, colomn: colomnsCount - 1)
    self.mapNode = SCNNode()
    self.currentMap = RealmMapModelData(value: mapModelData)
    self.createMapBoard(type: .fromMap(map: mapModelData))
  }

  subscript(rowIndex: Int, colomnIndex: Int) -> SCNNode? {
    if rowIndex >= 0, colomnIndex >= 0, rowIndex <= rowsCount, colomnIndex <= colomnsCount {
      return mapNode.childNodes[rowIndex * colomnsCount + colomnIndex]
    }
    return nil
  }

  func createMapBoard(type: MapBoardCreateType) {
    switch type {
    case .newMap:
      createMapBoard()
    case .fromMap(let mapModelData):
      createMapBoard(mapModelData: mapModelData)
    }
  }

  func mapAction(action: MapBoardActionType) {
    switch action {
    case .clear:
      clearMap()
    case let .replaceMapBlock(replacingNode, block):
      replaceMapBlock(replacingNode: replacingNode, with: block)
    case .generateRandomMap:
      randomMap()
    }
  }

  func getMapNode() -> SCNNode {
    mapNode
  }

  func getMapModelData() -> RealmMapModelData? {
    self.currentMap
  }

  private func updateMapModelData() {
    guard let map = getMapModel() else { return }
    self.currentMap?.lastEdited = Date()
    self.currentMap?.map = map
  }

  private func getMapModel() -> RealmMapModel? {
    var mapArray: [Int] = []
    for row in 0 ..< rowsCount {
      for colomn in 0 ..< colomnsCount {
        guard
          let node = self[row, colomn]?.childNodes.first,
          let obstacle = Obstacle.getObstacle(node: node)
        else { return nil }
        mapArray.append(obstacle.rawValue)
      }
    }
    return RealmMapModel(rowCount: rowsCount, colomnsCount: colomnsCount, map: mapArray)
  }

  private func clearMap() {
    mapNode.enumerateChildNodes { node, _ in
      node.removeFromParentNode()
    }
  }

  private func createMapBoard(mapModelData: RealmMapModelData? = nil) {
    let mapBoard = SCNNode()
    for row in 0 ..< rowsCount {
      for colomn in 0 ..< colomnsCount {
        let block = SCNNode()
        block.name = "\(row) \(colomn)"
        block.position = SCNVector3(x: Float(startX) + Float(22 * colomn), y: 14, z: Float(startZ) + Float(22 * row))
        if let blockModel = mapModelData?.map?[row, colomn]?.getBlock()?.flattenedClone() {
          block.addChildNode(blockModel)
        } else {
          guard let solidGroundBlock = Obstacle.solidGround.getBlock()?.flattenedClone() else { return }
          block.addChildNode(solidGroundBlock)
        }
        mapBoard.addChildNode(block)
      }
    }
    clearMap()
    mapNode = mapBoard
  }

  private func replaceMapBlock(replacingNode: SCNNode, with block: Obstacle) {
    guard let block = block.getBlock()?.flattenedClone() else { return }
    mapNode.enumerateChildNodes { containerNode, _ in
      if
        let blockInBlockContainer = containerNode.childNodes.first,
        replacingNode == blockInBlockContainer,
        let name = containerNode.name,
        name != startPoint.toString(),
        name != endPoint.toString() {
          let position = blockInBlockContainer.position
          blockInBlockContainer.removeFromParentNode()
          block.position = position
          containerNode.addChildNode(block)
      }
    }
    updateMapModelData()
  }

  private func randomMap() {
    mapNode.enumerateChildNodes { containerNode, _ in
      if
        let blockInBlockContainer = containerNode.childNodes.first,
        let block = Obstacle.init(rawValue: Int.random(in: 0 ..< 5))?.getBlock()?.flattenedClone(),
        let name = containerNode.name,
        name != startPoint.toString(),
        name != endPoint.toString() {
          let position = blockInBlockContainer.position
          blockInBlockContainer.removeFromParentNode()
          block.position = position
          containerNode.addChildNode(block)
      }
    }
    updateMapModelData()
  }

  deinit {
    clearMap()
    getMapNode().removeFromParentNode()
  }
}
