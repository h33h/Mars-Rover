//
//  SignInCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

protocol SignInFlow: AnyObject {
  func coordinateToSignUp()
}

class SignInCoordinator: BaseCoordinator, SignInFlow {
  override func start() {
    let signInVC: SignInViewController = DIContainer.shared.resolve()
    let signInViewModel: SignInViewModel = DIContainer.shared.resolve()
    signInViewModel.coordinator = self
    signInVC.viewModel = signInViewModel
    navigationController.pushViewController(signInVC, animated: true)
  }

  func coordinateToSignUp() {
    DIContainer.shared.assembler.apply(assembly: SignUpAssembly())
    let signUpCoordinator: SignUpCoordinator = DIContainer.shared.resolve()
    signUpCoordinator.navigationController = navigationController
    coordinate(to: signUpCoordinator)
  }
}
