//
//  GameScreenSceneCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

class GameScreenSceneCoordinator: BaseCoordinator, BackFlow {
  let map: RealmMap
  let path: [MatrixPoint]

  init(map: RealmMap, path: [MatrixPoint]) {
    self.map = map
    self.path = path
  }

  override func start() {
    let gameScreenSceneVC: GameScreenSceneViewController = DIContainer.shared.resolve()
    let gameScreenSceneViewModel: GameScreenSceneViewModel = DIContainer.shared.resolve(arguments: map, path)
    gameScreenSceneViewModel.coordinator = self
    gameScreenSceneVC.viewModel = gameScreenSceneViewModel
    navigationController.pushViewController(gameScreenSceneVC, animated: true)
  }

  func goBack() {
    navigationController.popViewController(animated: true)
    parentCoordinator?.didFinish(coordinator: self)
  }
}
