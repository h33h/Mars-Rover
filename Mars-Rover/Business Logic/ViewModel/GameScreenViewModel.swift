//
//  GameScreenViewModel.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

class GameScreenViewModel {
  weak var coordinator: GameScreenFlow?
  var realmService: RealmMapsServiceProtocol?
  private(set) lazy var maps: Box<[RealmMap]> = Box([RealmMap]())
  private(set) lazy var mapsError: Box<Error?> = Box(nil)

  func getLocalMaps() {
    self.maps.value.removeAll()
    let maps = realmService?.getLocalMaps()
    guard let maps = maps else { return }
    self.maps.value = maps.sorted { map1, map2 in
      map1.lastEdited > map2.lastEdited
    }
  }

  func findPath(map: RealmMap) -> [MatrixPoint]? {
    guard let pathFinder = FindShortestPath(on: map.mapContent) else { return nil }
    guard let path = pathFinder.shortestPath() else {
      mapsError.value = FindPathError.impassable
      return nil
    }
    let success = path.array.reversed().compactMap { $0 as? MatrixNode }.map { $0.point }
    return success
  }
}
