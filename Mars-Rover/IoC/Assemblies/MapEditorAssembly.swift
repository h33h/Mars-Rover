//
//  MapEditorAssembly.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class MapEditorAssembly: Assembly {
  func assemble(container: Container) {
    container.register(MapEditorCoordinator.self) { _ in
      MapEditorCoordinator()
    }

    container.register(MapEditorViewModel.self) { resolver in
      let viewModel = MapEditorViewModel()
      viewModel.journalService = resolver.resolve(MapsJournalService.self)
      viewModel.realmService = resolver.resolve(RealmMapsService.self)
      viewModel.syncService = resolver.resolve(MapsSyncService.self)
      return viewModel
    }

    container.register(MapEditorViewController.self) { _ in
      StoryboardScene.MainMenu.mapEditorViewController.instantiate()
    }
  }
}
