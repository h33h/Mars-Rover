//
//  GameScreenSceneAssembly.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class GameScreenSceneAssembly: Assembly {
  func assemble(container: Container) {
    container.register(GameScreenSceneCoordinator.self) { _, map, path in
      GameScreenSceneCoordinator(map: map, path: path)
    }

    container.register(GameScreenSceneViewModel.self) { (resolver, map: RealmMap, path: [MatrixPoint]) in
      let viewModel = GameScreenSceneViewModel()
      if let mapContent = map.mapContent {
        viewModel.mapManager = resolver.resolve(MapManager.self, argument: mapContent)
      }

      var mapNodesPath: [SCNBlockNode] = []
      for point in path {
        viewModel.mapManager?.mapNode.enumerateChildNodes { node, _ in
          if let node = node as? SCNBlockNode, node.positionOnMap == point {
            mapNodesPath.append(node)
            return
          }
        }
      }

      viewModel.roverManager = resolver.resolve(RoverManager.self, argument: mapNodesPath)
      return viewModel
    }

    container.register(GameScreenSceneViewController.self) { _ in
      StoryboardScene.GameScreens.gameScreenSceneViewController.instantiate()
    }
  }
}
