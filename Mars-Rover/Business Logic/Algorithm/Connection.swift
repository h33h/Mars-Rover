//
//  Connection.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

class Connection {
  public let toNode: Node
  public let weight: Int

  public init(to node: Node, weight: Int) {
    self.toNode = node
    self.weight = weight
  }
}
