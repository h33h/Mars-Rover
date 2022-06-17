//
//  SignInAssembly.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class SignInAssembly: Assembly {
  func assemble(container: Container) {
    container.register(SignInCoordinator.self) { _ in
      SignInCoordinator()
    }

    container.register(SignInViewModel.self) { resolver in
      let viewModel = SignInViewModel()
      viewModel.authService = resolver.resolve(FirebaseAuthService.self)
      return viewModel
    }

    container.register(SignInViewController.self) { _ in
      StoryboardScene.Auth.signInViewController.instantiate()
    }
  }
}
