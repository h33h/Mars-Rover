//
//  MainMenuCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

class MainMenuCoordinator: Coordinator {
  weak var parentCoordinator: MainCoordinator?
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    guard let mainMenuVC = MainMenuViewController.instantiate(from: "MainMenu") else { return }
    mainMenuVC.coordinator = self
    navigationController.pushViewController(mainMenuVC, animated: true)
  }

  func goToMaps() {
    let child = MapEditorCoordinator(navigationController: navigationController)
    child.parentCoordinator = self
    childCoordinators.append(child)
    child.start()
  }

  func goBack() {
    parentCoordinator?.childDidFinish(child: self)
  }

  func childDidFinish(child: Coordinator?) {
    for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
      childCoordinators.remove(at: index)
      break
    }
  }
}
