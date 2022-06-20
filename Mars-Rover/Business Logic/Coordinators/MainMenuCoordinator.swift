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

class MainMenuCoordinator: BaseCoordinator, MainMenuFlow {
  override func start() {
    DIContainer.shared.assembler.apply(assemblies: [MapServicesAssembly(), ManagerAssembly()])
    let mainMenuVC: MainMenuViewController = DIContainer.shared.resolve()
    let mainMenuViewModel: MainMenuViewModel = DIContainer.shared.resolve()
    mainMenuViewModel.coordinator = self
    mainMenuVC.viewModel = mainMenuViewModel
    navigationController.pushViewController(mainMenuVC, animated: true)
  }

  func coordinateToMapEditor() {
    DIContainer.shared.assembler.apply(assembly: MapEditorAssembly())
    let mapEditorCoordinator: MapEditorCoordinator = DIContainer.shared.resolve()
    mapEditorCoordinator.navigationController = navigationController
    coordinate(to: mapEditorCoordinator)
  }

  func coordinateToGameScreen() {
    DIContainer.shared.assembler.apply(assembly: GameScreenAssembly())
    let gameScreenCoordinator: GameScreenCoordinator = DIContainer.shared.resolve()
    gameScreenCoordinator.navigationController = navigationController
    coordinate(to: gameScreenCoordinator)
  }
}
