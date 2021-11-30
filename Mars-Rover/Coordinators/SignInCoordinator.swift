//
//  SignInCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

protocol SignInFlow: AnyObject {
  func coordinateToMainMenu()
  func coordinateToSignUp()
}

class SignInCoordinator: Coordinator, SignInFlow {
  let router: Router

  init(router: Router) {
    self.router = router
  }

  func start() {
    guard let signInVC = SignInFormViewController.instantiate(from: "Auth") else { return }
    signInVC.coordinator = self
    router.push(signInVC, isAnimated: true)
  }

  // MARK: - Flow Methods
  func coordinateToMainMenu() {
    let mainMenuCoordinator = MainMenuCoordinator(router: router)
    coordinate(to: mainMenuCoordinator)
  }

  func coordinateToSignUp() {
    let signUpCoordinator = SignUpCoordinator(router: router)
    coordinate(to: signUpCoordinator)
  }
}
