//
//  GameScreenSceneViewModel.swift
//  Mars Rover
//
//  Created by XXX on 24.11.21.
//

class GameScreenSceneViewModel {
  weak var coordinator: BackFlow?
  var mapManager: MapManagerProtocol?
  var roverManager: RoverManagerProtocol?

  func completeMap() {
    roverManager?.roverCompleteMap()
  }
}
