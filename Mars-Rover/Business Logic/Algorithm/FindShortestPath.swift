//
//  FindPath.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

import Foundation

class FindShortestPath {
  private var matrix: [[MatrixNode]]
  private var matrixRowCount: Int
  private var matrixColomnCount: Int
  private var startPoint: MatrixNode?
  private var endPoint: MatrixNode?

  init?(on map: RealmMapContent) {
    guard !map.map.isEmpty else { return nil }
    self.matrixRowCount = map.getMapSize().getSize().rows
    self.matrixColomnCount = map.getMapSize().getSize().colomns
    self.matrix = ([])
    for rowIndex in 0 ..< matrixRowCount {
      self.matrix.append([MatrixNode]())
      for colomnIndex in 0 ..< matrixColomnCount {
        guard let obstacle = map[rowIndex, colomnIndex] else { return nil }
        let node = MatrixNode(point: MatrixPoint(row: rowIndex, colomn: colomnIndex), weight: obstacle)
        self.matrix[rowIndex].append(node)
        if rowIndex == map.startGamePoint().row, colomnIndex == map.startGamePoint().colomn {
          self.startPoint = node
        }
        if rowIndex == map.endGamePoint().row, colomnIndex == map.endGamePoint().colomn {
          self.endPoint = node
        }
      }
    }
    self.matrix.forEach { $0.forEach { self.setupConnections(node: $0) } }
  }

  private func nodeAddConnections(node: MatrixNode, with neighborNodes: [MatrixNode?]) {
    for neighborNode in neighborNodes {
      guard let neighborNode = neighborNode else { return }
      node.addConnection(to: neighborNode, weight: neighborNode.weight.rawValue)
    }
  }

  private func setupConnections(node: MatrixNode) {
    let currentNodeRow = node.point.row
    let currentNodeColomn = node.point.colomn

    let leftNode = self[currentNodeRow, currentNodeColomn - 1]
    let rightNode = self[currentNodeRow, currentNodeColomn + 1]
    let upNode = self[currentNodeRow - 1, currentNodeColomn]
    let downNode = self[currentNodeRow + 1, currentNodeColomn]

    if currentNodeRow == 0, currentNodeColomn == 0 {
      nodeAddConnections(node: node, with: [rightNode, downNode])
      return
    }

    if currentNodeRow == 0, currentNodeColomn == matrixColomnCount - 1 {
      nodeAddConnections(node: node, with: [leftNode, downNode])
      return
    }

    if currentNodeRow == matrixRowCount - 1, currentNodeColomn == 0 {
      nodeAddConnections(node: node, with: [rightNode, upNode])
      return
    }

    if currentNodeRow == matrixRowCount - 1, currentNodeColomn == matrixColomnCount - 1 {
      nodeAddConnections(node: node, with: [leftNode, upNode])
      return
    }

    if currentNodeRow == 0 {
      nodeAddConnections(node: node, with: [leftNode, rightNode, downNode])
      return
    }

    if currentNodeRow == matrixRowCount - 1 {
      nodeAddConnections(node: node, with: [leftNode, rightNode, upNode])
      return
    }

    if currentNodeColomn == 0 {
      nodeAddConnections(node: node, with: [rightNode, upNode, downNode])
      return
    }

    if currentNodeColomn == matrixColomnCount - 1 {
      nodeAddConnections(node: node, with: [leftNode, upNode, downNode])
      return
    }

    nodeAddConnections(node: node, with: [leftNode, rightNode, upNode, downNode])
  }

  func shortestPath() -> Path? {
    guard let startPoint = startPoint, let endPoint = endPoint else {
      return nil
    }

    var frontier: [Path] = [] {
      // the frontier has to be always ordered
      didSet { frontier.sort { $0.cumulativeWeight < $1.cumulativeWeight } }
    }

    frontier.append(Path(to: startPoint)) // the frontier is made by a path that starts nowhere and ends in the source

    while !frontier.isEmpty {
      let cheapestPathInFrontier = frontier.removeFirst() // getting the cheapest path available
      guard !cheapestPathInFrontier.node.visited else { continue } // making sure we haven't visited the node already

      if cheapestPathInFrontier.node === endPoint {
        return cheapestPathInFrontier // found the cheapest path
      }

      cheapestPathInFrontier.node.visited = true

      for connection in cheapestPathInFrontier.node.connections
      where !connection.toNode.visited && connection.weight != Obstacle.pit.rawValue {
        // adding new paths to our frontier
        frontier.append(Path(to: connection.toNode, via: connection, previousPath: cheapestPathInFrontier))
      }
    } // end while
    return nil // we didn't find a path 
  }

  private subscript(row: Int, colomn: Int) -> MatrixNode? {
    for (rowIndex, nodes) in matrix.enumerated() {
      for (colomnIndex, node) in nodes.enumerated() where row == rowIndex && colomn == colomnIndex {
        return node
      }
    }
    return nil
  }
}
