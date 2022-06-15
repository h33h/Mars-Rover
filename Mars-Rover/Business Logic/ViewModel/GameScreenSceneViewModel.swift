//
//  GameScreenSceneViewModel.swift
//  Mars Rover
//
//  Created by XXX on 24.11.21.
//

import Foundation

class GameScreenSceneViewModel {
  let mapCreator: MapCreatorProtocol
  let roverManager: RoverManagerProtocol
  init(mapCreator: MapCreatorProtocol, roverManager: RoverManagerProtocol) {
    self.mapCreator = mapCreator
    self.roverManager = roverManager
  }

  func completeMap() {
    roverManager.roverCompleteMap()
  }
}
