//
//  GameScreenSceneCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

class GameScreenSceneCoordinator: Coordinator, BackFlow {
  let router: Router
  let map: RealmMapModelData
  let path: [MatrixPoint]

  init(router: Router, map: RealmMapModelData, path: [MatrixPoint]) {
    self.router = router
    self.map = map
    self.path = path
  }

  func start() {
    guard let gameScreenSceneVC = GameScreenSceneViewController.instantiate(from: "GameScreens") else { return }
    gameScreenSceneVC.coordinator = self
    guard let mapCreator = MapCreator(mapModelData: map) else { return }
    var mapNodesPath: [SCNBlockNode] = []
    for point in path {
      mapCreator.mapNode.enumerateChildNodes { node, _ in
        if let node = node as? SCNBlockNode, node.positionOnMap == point {
          mapNodesPath.append(node)
          return
        }
      }
    }
    let viewModel = GameScreenSceneViewModel(mapCreator: mapCreator, roverManager: RoverManager(path: mapNodesPath))
    gameScreenSceneVC.setViewModel(viewModel: viewModel)
    router.push(gameScreenSceneVC, isAnimated: true)
  }

  func goBack() {
    router.pop(isAnimated: true)
  }
}
