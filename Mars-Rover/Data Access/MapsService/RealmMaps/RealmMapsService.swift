//
//  RealmMapsService.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import RealmSwift

final class RealmMapsService: RealmMapsServiceProtocol {
  var mapActionService: RealmMapsActionServiceProtocol?
  private let realm: Realm? = Realm.safeInit()

  func mapAction(is action: RealmMapAction) {
    mapActionService?.mapAction(is: action)
  }

  func getLocalMaps() -> [RealmMap]? {
    guard let realm = realm else { return nil }

    let maps = realm.objects(RealmMap.self)
    return Array(maps)
  }

  func removeAllLocalMaps() {
    guard let realm = realm else { return }

    realm.safeWrite { realm.deleteAll() }
  }
}
