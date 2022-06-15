//
//  GameScreenViewModel.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

import Foundation

class GameScreenViewModel {
  let realmService: RealmMapsServiceProtocol
  var maps: Box<[RealmMapModelData]>
  var isUpdated: Box<Bool>
  var errorMessage: Box<String?>

  init(realmService: RealmMapsServiceProtocol) {
    self.realmService = realmService
    self.maps = Box([RealmMapModelData]())
    self.isUpdated = Box(false)
    self.errorMessage = Box(nil)
  }

  func getLocalMaps() {
    self.maps.value.removeAll()
    let maps = realmService.getLocalMaps()
    guard let maps = maps else { return }
    self.maps.value = maps.sorted { map1, map2 in
      map1.lastEdited > map2.lastEdited
    }
    self.isUpdated.value.toggle()
  }

  func findPath(mapModelData: RealmMapModelData) -> [MatrixPoint]? {
    guard let map = mapModelData.map else { return nil }
    guard let pathFinder = FindShortestPath(on: map) else { return nil }
    guard let path = pathFinder.shortestPath() else {
      errorMessage.value = "Map is not passable"
      return nil
    }
    let succession = path.array.reversed().compactMap { $0 as? MatrixNode }.map { $0.point }
    return succession
  }
}
