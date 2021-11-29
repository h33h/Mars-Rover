//
//  PlayCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

protocol GameScreenFlow: AnyObject {
  func coordinateToGameScreenScene(map: RealmMapModelData, path: [MatrixPoint])
}

class GameScreenCoordinator: Coordinator, GameScreenFlow, BackFlow {
  let router: Router

  init(router: Router) {
    self.router = router
  }

  func start() {
    guard let gameScreenVC = GameScreenViewController.instantiate(from: "MainMenu") else { return }
    gameScreenVC.coordinator = self
    router.push(gameScreenVC, isAnimated: true)
  }

  func coordinateToGameScreenScene(map: RealmMapModelData, path: [MatrixPoint]) {
    let gameScreenSceneCoordinator = GameScreenSceneCoordinator(router: router, map: map, path: path)
    coordinate(to: gameScreenSceneCoordinator)
  }

  func goBack() {
    router.pop(isAnimated: true)
  }
}