//
//  SignUpCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

class SignUpCoordinator: BaseCoordinator, BackFlow {
  override func start() {
    let signUpVC: SignUpViewController = DIContainer.shared.resolve()
    let signUpViewModel: SignUpViewModel = DIContainer.shared.resolve()
    signUpViewModel.coordinator = self
    signUpVC.viewModel = signUpViewModel
    navigationController.pushViewController(signUpVC, animated: true)
  }

  func goBack() {
    navigationController.popViewController(animated: true)
    parentCoordinator?.didFinish(coordinator: self)
  }
}
