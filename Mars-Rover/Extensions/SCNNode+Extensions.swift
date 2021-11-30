//
//  SCNNode+Extensions.swift
//  Mars Rover
//
//  Created by XXX on 24.11.21.
//

import SceneKit

extension SCNNode {
  func getBlockSize() -> SCNVector3 {
    let min = self.boundingBox.min
    let max = self.boundingBox.max
    return SCNVector3(x: (max.x - min.x), y: (max.y - min.y), z: (max.z - min.z))
  }
}
