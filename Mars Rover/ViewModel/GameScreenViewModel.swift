//
//  GameScreenViewModel.swift
//  Mars Rover
//
//  Created by XXX on 21.11.21.
//

import Foundation

class GameScreenViewModel {
  private let realmService = RealmMapsServce(mapActionService: RealmMapsActionService())
  var maps = Box([RealmMapModelData]())
  var isUpdated = Box(false)

  func getLocalMaps() {
    self.maps.value.removeAll()
    let maps = realmService.getLocalMaps()
    guard let maps = maps else { return }
    self.maps.value = maps
    self.isUpdated.value = true
  }

  func findPath(mapModelData: RealmMapModelData) {
    guard let map = mapModelData.map else { return }
    var mapArray: [[Obstacle]] = []
    for rowIndex in 0 ..< map.getMapSize().rows {
      mapArray.append([Obstacle]())
      for colomnIndex in 0 ..< map.getMapSize().colomns {
        guard let obs = map[rowIndex, colomnIndex] else { return }
        mapArray[rowIndex].append(obs)
      }
    }
    guard
      let pathFinder = FindShortestPath(
        matrix: mapArray,
        startPoint: MatrixPoint(row: map.getMapSize().rows / 2, colomn: 0),
        endPoint: MatrixPoint(row: map.getMapSize().rows / 2, colomn: map.getMapSize().colomns)
      )
    else { return }
    let path = pathFinder.shortestPath()
    let succession = path?.array.reversed().compactMap { $0 as? MartixNode }.map { $0.point }
    guard let succession = succession else { return }
    for point in succession {
      print("(\(point.row), \(point.colomn)) ")
    }
  }
}
