//
//  SignUpAssembly.swift
//  Mars Rover
//
//  Created by XXX on 17.06.22.
//

import Swinject

class SignUpAssembly: Assembly {
  func assemble(container: Container) {
    container.register(SignUpCoordinator.self) { _ in
      SignUpCoordinator()
    }

    container.register(SignUpViewModel.self) { resolver in
      let viewModel = SignUpViewModel()
      viewModel.authService = resolver.resolve(FirebaseAuthService.self)
      return viewModel
    }

    container.register(SignUpViewController.self) { _ in
      StoryboardScene.Auth.signUpViewController.instantiate()
    }
  }
}
