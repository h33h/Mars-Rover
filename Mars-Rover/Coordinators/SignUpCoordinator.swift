//
//  SignUpCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

class SignUpCoordinator: Coordinator, BackFlow {
  let router: Router

  init(router: Router) {
    self.router = router
  }

  func start() {
    guard let signUpVC = SignUpFormViewController.instantiate(from: "Auth") else { return }
    signUpVC.coordinator = self
    router.push(signUpVC, isAnimated: true)
  }

  // MARK: - Flow Methods
  func goBack() {
    router.pop(isAnimated: true)
  }
}
