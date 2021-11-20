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

  func goToMapEditorScene(map: RealmMapModelData? = nil, journalService: MapsJournalServiceProtocol, realmMapService: RealmMapsServceProtocol) {
    guard let mapEditorSceneVC = MapEditorSceneViewController.instantiate(from: "GameScreens") else { return }
    mapEditorSceneVC.coordinator = self
    let viewModel = MapEditorSceneViewModel()
    viewModel.setRealmService(service: realmMapService)
    viewModel.setJournalService(service: journalService)
    if let map = map {
      viewModel.setupMapManager(type: .fromMap(map: map))
    } else {
      viewModel.setupMapManager(type: .newMap)
    }
    mapEditorSceneVC.setViewModel(viewModel: viewModel)
    navigationController.pushViewController(mapEditorSceneVC, animated: true)
  }

  func goBack() {
    parentCoordinator?.childDidFinish(child: self)
  }
}
