//
//  MapEditorSceneAssembly.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class MapEditorSceneAssembly: Assembly {
  func assemble(container: Container) {
    container.register(MapEditorSceneCoordinator.self) { _, map in
      MapEditorSceneCoordinator(map: map)
    }

    container.register(MapEditorSceneViewModel.self) { (resolver, map: RealmMap?) in
      if
        let map = map,
        let mapContent = map.mapContent
      {
        let viewModel = MapEditorSceneViewModel(map: map, mapType: .existed)
        viewModel.realmMapsService = resolver.resolve(RealmMapsService.self)
        viewModel.journalService = resolver.resolve(MapsJournalService.self)
        viewModel.mapManager = resolver.resolve(MapManager.self, argument: mapContent)
        return viewModel
      }

      let map = RealmMap(
        id: .generate(),
        label: "",
        lastEdited: Date(),
        mapContent: RealmMapContent(size: MapSize())
      )
      let viewModel = MapEditorSceneViewModel(map: map, mapType: .new)
      viewModel.realmMapsService = resolver.resolve(RealmMapsService.self)
      viewModel.journalService = resolver.resolve(MapsJournalService.self)
      if let mapContent = map.mapContent {
        viewModel.mapManager = resolver.resolve(MapManager.self, argument: mapContent)
      }
      return viewModel
    }

    container.register(MapEditorSceneViewController.self) { _ in
      StoryboardScene.GameScreens.mapEditorSceneViewController.instantiate()
    }
  }
}
