//
//  MenuAssembly.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class MenuAssembly: Assembly {
  func assemble(container: Container) {
    container.register(MainMenuCoordinator.self) { _ in
      MainMenuCoordinator()
    }

    container.register(MainMenuViewModel.self) { resolver in
      let viewModel = MainMenuViewModel()
      viewModel.authService = resolver.resolve(FirebaseAuthService.self)
      viewModel.profileService = resolver.resolve(FirebaseProfileService.self)
      return viewModel
    }

    container.register(MainMenuViewController.self) { _ in
      StoryboardScene.MainMenu.mainMenuViewController.instantiate()
    }
  }
}
