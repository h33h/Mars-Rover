//
//  MatrixNode.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

class MatrixNode: Node {
  let point: MatrixPoint
  let weight: Obstacle
  init(point: MatrixPoint, weight: Obstacle) {
    self.point = point
    self.weight = weight
    super.init()
  }
}

extension MatrixNode {
  func addConnection(to node: MatrixNode, weight: Int) {
    self.connections.append(Connection(to: node, weight: weight))
  }
}
