//
//  GameScreenAssembly.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class GameScreenAssembly: Assembly {
  func assemble(container: Container) {
    container.register(GameScreenCoordinator.self) { _ in
      GameScreenCoordinator()
    }

    container.register(GameScreenViewModel.self) { resolver in
      let viewModel = GameScreenViewModel()
      viewModel.realmService = resolver.resolve(RealmMapsService.self)
      return viewModel
    }

    container.register(GameScreenViewController.self) { _ in
      StoryboardScene.MainMenu.gameScreenViewController.instantiate()
    }
  }
}
