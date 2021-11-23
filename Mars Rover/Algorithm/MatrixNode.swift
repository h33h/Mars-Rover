//
//  MatrixNode.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

import Foundation

class MartixNode: Node {
  let point: MatrixPoint
  let weight: Obstacle
  init(point: MatrixPoint, weight: Obstacle) {
    self.point = point
    self.weight = weight
    super.init()
  }
}

extension MartixNode {
  func addConnection(to node: MartixNode, weight: Int) {
    self.connections.append(Connection(to: node, weight: weight))
  }
}
