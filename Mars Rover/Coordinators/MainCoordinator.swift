//
//  MainCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

class MainCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    guard let signInVC = SignInFormViewController.instantiate(from: "Auth") else { return }
    signInVC.coordinator = self
    navigationController.pushViewController(signInVC, animated: true)
  }

  func goToSignUpForm() {
    guard let signUpVC = SignUpFormViewController.instantiate(from: "Auth") else { return }
    signUpVC.coordinator = self
    navigationController.pushViewController(signUpVC, animated: true)
  }

  func goToMainMenu() {
    let child = MainMenuCoordinator(navigationController: navigationController)
    child.parentCoordinator = self
    childCoordinators.append(child)
    child.start()
  }

  func childDidFinish(child: Coordinator?) {
    for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
      childCoordinators.remove(at: index)
      break
    }
  }
}
