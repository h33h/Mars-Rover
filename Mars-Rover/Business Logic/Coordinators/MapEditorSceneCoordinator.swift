//
//  MapEditorSceneCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit
import RealmSwift

class MapEditorSceneCoordinator: BaseCoordinator, BackFlow {
  let map: RealmMap?

  init(map: RealmMap?) {
    self.map = map
  }

  override func start() {
    let mapEditorSceneVC: MapEditorSceneViewController = DIContainer.shared.resolve()
    let mapEditorSceneViewModel: MapEditorSceneViewModel = DIContainer.shared.resolve(argument: map)
    mapEditorSceneViewModel.coordinator = self
    mapEditorSceneVC.viewModel = mapEditorSceneViewModel
    navigationController.pushViewController(mapEditorSceneVC, animated: true)
  }

  func goBack() {
    navigationController.popViewController(animated: true)
    parentCoordinator?.didFinish(coordinator: self)
  }
}
