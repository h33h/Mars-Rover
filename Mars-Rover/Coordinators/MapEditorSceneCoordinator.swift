//
//  MapEditorSceneCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

class MapEditorSceneCoordinator: Coordinator, BackFlow {
  let router: Router
  let map: RealmMapModelData?

  init(router: Router, map: RealmMapModelData?) {
    self.router = router
    self.map = map
  }

  func start() {
    guard let mapEditorSceneVC = MapEditorSceneViewController.instantiate(from: "GameScreens") else { return }
    mapEditorSceneVC.coordinator = self
    if let map = map {
      guard let mapCreator = MapCreator(mapModelData: map) else { return }
      let viewModel = MapEditorSceneViewModel(
        realmMapsService: RealmMapsService.shared,
        journalService: MapsJournalService.shared,
        mapCreator: mapCreator
      )
      mapEditorSceneVC.setViewModel(viewModel: viewModel)
    } else {
      let viewModel = MapEditorSceneViewModel(
        realmMapsService: RealmMapsService.shared,
        journalService: MapsJournalService.shared,
        mapCreator: MapCreator(size: .defaultSize)
      )
      mapEditorSceneVC.setViewModel(viewModel: viewModel)
    }
    router.push(mapEditorSceneVC, isAnimated: true)
  }

  func goBack() {
    router.pop(isAnimated: true)
  }
}
