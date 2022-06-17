//
//  Path.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

class Path {
  public let cumulativeWeight: Int
  public let node: Node
  public let previousPath: Path?

  init(to node: Node, via connection: Connection? = nil, previousPath path: Path? = nil) {
    if
      let previousPath = path,
      let viaConnection = connection {
      self.cumulativeWeight = viaConnection.weight + previousPath.cumulativeWeight
    } else {
      self.cumulativeWeight = .zero
    }

    self.node = node
    self.previousPath = path
  }
}

extension Path {
  var array: [Node] {
    var array: [Node] = [self.node]

    var iterativePath = self
    while let path = iterativePath.previousPath {
      array.append(path.node)

      iterativePath = path
    }

    return array
  }
}
