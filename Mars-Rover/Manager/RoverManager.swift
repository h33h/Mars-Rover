//
//  RoverManager.swift
//  Mars Rover
//
//  Created by XXX on 24.11.21.
//

import SceneKit

enum MarsRoverDirection {
  case left
  case right
  case forward
  case backward

  var angle: Float {
    switch self {
    case .left:
      return Float.pi
    case .right:
      return 0
    case .forward:
      return Float.pi / 2
    case .backward:
      return -Float.pi / 2
    }
  }
}

protocol RoverManagerProtocol {
  var marsRover: SCNNode { get }
  func roverCompleteMap()
}

class RoverManager: RoverManagerProtocol {
  private(set) var marsRover: SCNNode
  private(set) var path: [SCNBlockNode]

  init(path: [SCNBlockNode]) {
    self.path = path
    self.marsRover = SCNNode()
    self.setupRover()
  }

  private func setupRover() {
    guard
      let roverModel = SCNScene(named: "art.scnassets/marsRover.scn")?.rootNode.childNodes.first,
      let firstPoint = path.first
    else { return }
    roverModel.position = SCNVector3(
      x: firstPoint.position.x,
      y: firstPoint.position.y + firstPoint.getBlockSize().y / 2,
      z: firstPoint.position.z
    )
    roverModel.eulerAngles = SCNVector3(x: 0, y: MarsRoverDirection.forward.angle, z: 0)
    path.forEach { print($0.positionOnMap) }
    marsRover.addChildNode(roverModel)
  }

  private func turnModelTo(direction: MarsRoverDirection) -> SCNAction {
    let rotateAction = SCNAction.rotate(toAxisAngle: SCNVector4(x: 0, y: 1, z: 0, w: direction.angle), duration: 0.5)
    return rotateAction
  }

  private func moveTo(point: SCNBlockNode, from: SCNBlockNode?) -> SCNAction? {
    var actions: [SCNAction] = []
    let toVector = point.position
    let moveAction = SCNAction.move(
      to: SCNVector3(
        x: toVector.x,
        y: toVector.y + point.getBlockSize().y / 2,
        z: toVector.z
      ),
      duration: 0.5
    )
    if let fromPosition = from?.positionOnMap {
      let toPosition = point.positionOnMap
      if fromPosition.colomn < toPosition.colomn {
        actions.append(turnModelTo(direction: .forward))
      }
      if fromPosition.colomn > toPosition.colomn {
        actions.append(turnModelTo(direction: .backward))
      }
      if fromPosition.row < toPosition.row {
        actions.append(turnModelTo(direction: .right))
      }
      if fromPosition.row > toPosition.row {
        actions.append(turnModelTo(direction: .left))
      }
    }
    actions.append(moveAction)
    return SCNAction.sequence(actions)
  }

  func roverCompleteMap() {
    var actions: [SCNAction] = []
    SCNTransaction.animationDuration = 2.0
    var previousPoint: SCNBlockNode?
    for point in path {
      point.geometry?.materials.first?.diffuse.contents = UIColor.green.withAlphaComponent(1)
      guard let moveAction = moveTo(point: point, from: previousPoint) else { return }
      actions.append(moveAction)
      previousPoint = point
    }
    let sequence = SCNAction.sequence(actions)
    marsRover.childNodes.first?.runAction(sequence)
  }
}
