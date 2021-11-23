//
//  PlayCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

import UIKit

class PlayCoordinator: Coordinator {
  weak var parentCoordinator: MainMenuCoordinator?
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    guard let gameVC = GameScreenViewController.instantiate(from: "MainMenu") else { return }
    gameVC.coordinator = self
    navigationController.pushViewController(gameVC, animated: true)
  }

  func goBack() {
    parentCoordinator?.childDidFinish(child: self)
  }
}
