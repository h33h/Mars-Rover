//
//  MapEditorCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 18.11.21.
//

import UIKit

protocol MapEditorFlow: AnyObject {
  func coordinateToMapEditorScene(map: RealmMapModelData?)
}

class MapEditorCoordinator: Coordinator, MapEditorFlow, BackFlow {
  let router: Router

  init(router: Router) {
    self.router = router
  }

  func start() {
    guard let mapEditorVC = MapEditorViewController.instantiate(from: "MainMenu") else { return }
    mapEditorVC.coordinator = self
    router.push(mapEditorVC, isAnimated: true)
  }

  func coordinateToMapEditorScene(map: RealmMapModelData? = nil) {
    let mapEditorSceneCoordinator = MapEditorSceneCoordinator(router: router, map: map)
    coordinate(to: mapEditorSceneCoordinator)
  }

  func goBack() {
    router.pop(isAnimated: true)
  }
}
