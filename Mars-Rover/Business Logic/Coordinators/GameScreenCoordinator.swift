//
//  PlayCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

protocol GameScreenFlow: AnyObject {
  func coordinateToGameScreenScene(map: RealmMap, path: [MatrixPoint])
}

class GameScreenCoordinator: Coordinator, GameScreenFlow, BackFlow {
  let router: Router

  init(router: Router) {
    self.router = router
  }

  func start() {
    let gameScreenVC = StoryboardScene.MainMenu.gameScreenViewController.instantiate()
    gameScreenVC.coordinator = self
    router.push(gameScreenVC, isAnimated: true)
  }

  func coordinateToGameScreenScene(map: RealmMap, path: [MatrixPoint]) {
    let gameScreenSceneCoordinator = GameScreenSceneCoordinator(router: router, map: map, path: path)
    coordinate(to: gameScreenSceneCoordinator)
  }

  func goBack() {
    router.pop(isAnimated: true)
  }
}
