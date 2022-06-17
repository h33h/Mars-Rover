//
//  MapEditorCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 18.11.21.
//

import UIKit

protocol MapEditorFlow: BackFlow {
  func coordinateToMapEditorScene(map: RealmMap?)
}

class MapEditorCoordinator: BaseCoordinator, MapEditorFlow {
  override func start() {
    let mapEditorVC: MapEditorViewController = DIContainer.shared.resolve()
    let mapEditorViewModel: MapEditorViewModel = DIContainer.shared.resolve()
    mapEditorViewModel.coordinator = self
    mapEditorVC.viewModel = mapEditorViewModel
    navigationController.pushViewController(mapEditorVC, animated: true)
  }

  func coordinateToMapEditorScene(map: RealmMap? = nil) {
    DIContainer.shared.assembler.apply(assembly: MapEditorSceneAssembly())
    let mapEditorSceneCoordinator: MapEditorSceneCoordinator = DIContainer.shared.resolve(argument: map)
    mapEditorSceneCoordinator.navigationController = navigationController
    coordinate(to: mapEditorSceneCoordinator)
  }

  func goBack() {
    navigationController.popViewController(animated: true)
    parentCoordinator?.didFinish(coordinator: self)
  }
}
