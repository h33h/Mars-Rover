//
//  PlayCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

protocol GameScreenFlow: BackFlow {
  func coordinateToGameScreenScene(map: RealmMap, path: [MatrixPoint])
}

class GameScreenCoordinator: BaseCoordinator, GameScreenFlow {
  override func start() {
    let gameScreenVC: GameScreenViewController = DIContainer.shared.resolve()
    let gameScreenViewModel: GameScreenViewModel = DIContainer.shared.resolve()
    gameScreenViewModel.coordinator = self
    gameScreenVC.viewModel = gameScreenViewModel
    navigationController.pushViewController(gameScreenVC, animated: true)
  }

  func coordinateToGameScreenScene(map: RealmMap, path: [MatrixPoint]) {
    DIContainer.shared.assembler.apply(assembly: GameScreenSceneAssembly())
    let gameScreenSceneCoordinator: GameScreenSceneCoordinator = DIContainer.shared.resolve(arguments: map, path)
    gameScreenSceneCoordinator.navigationController = navigationController
    coordinate(to: gameScreenSceneCoordinator)
  }

  func goBack() {
    navigationController.popViewController(animated: true)
    parentCoordinator?.didFinish(coordinator: self)
  }
}
