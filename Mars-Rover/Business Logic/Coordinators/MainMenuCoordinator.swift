//
//  MainMenuCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

protocol MainMenuFlow: AnyObject {
  func coordinateToMapEditor()
  func coordinateToGameScreen()
}

class MainMenuCoordinator: Coordinator, MainMenuFlow, BackFlow {
  let router: Router

  init(router: Router) {
    self.router = router
  }

  func start() {
    let mainMenuVC = StoryboardScene.MainMenu.mainMenuViewController.instantiate()
    mainMenuVC.coordinator = self
    router.push(mainMenuVC, isAnimated: true)
  }

  func coordinateToMapEditor() {
    let mapEditorCoordinator = MapEditorCoordinator(router: router)
    coordinate(to: mapEditorCoordinator)
  }

  func coordinateToGameScreen() {
    let gameScreenCoordinator = GameScreenCoordinator(router: router)
    coordinate(to: gameScreenCoordinator)
  }

  func goBack() {
    router.pop(isAnimated: true)
  }
}
