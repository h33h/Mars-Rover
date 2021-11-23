//
//  MapEditorCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 18.11.21.
//

import UIKit

class MapEditorCoordinator: Coordinator {
  weak var parentCoordinator: MainMenuCoordinator?
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    guard let mapEditorVC = MapEditorViewController.instantiate(from: "MainMenu") else { return }
    mapEditorVC.coordinator = self
    navigationController.pushViewController(mapEditorVC, animated: true)
  }

  func goToMapEditorScene(map: RealmMapModelData? = nil) {
    guard let mapEditorSceneVC = MapEditorSceneViewController.instantiate(from: "GameScreens") else { return }
    mapEditorSceneVC.coordinator = self
    if let map = map {
      guard let mapCreator = MapCreator(mapModelData: map) else { return }
      let viewModel = MapEditorSceneViewModel(
        realmMapsService: RealmMapsServce.shared,
        journalService: MapsJournalService.shared,
        mapCreator: mapCreator
      )
      mapEditorSceneVC.setViewModel(viewModel: viewModel)
    } else {
      let viewModel = MapEditorSceneViewModel(
        realmMapsService: RealmMapsServce.shared,
        journalService: MapsJournalService.shared,
        mapCreator: MapCreator(size: .defaultSize)
      )
      mapEditorSceneVC.setViewModel(viewModel: viewModel)
    }
    navigationController.pushViewController(mapEditorSceneVC, animated: true)
  }

  func goBack() {
    parentCoordinator?.childDidFinish(child: self)
  }
}
