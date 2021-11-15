//
//  RealmMapsService.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import Foundation
import RealmSwift

protocol RealmMapsServceProtocol {
  func mapAction(is action: RealmMapAction)
  func getLocalMaps() -> [RealmMapModelData]?
  func removeAllLocalMaps()
}

class RealmMapsServce: RealmMapsServceProtocol {
  private let mapActionService: MapActionProtocol
  private let realm: Realm?

  init(mapActionService: MapActionProtocol) {
    self.mapActionService = mapActionService
    self.realm = Realm.safeInit()
  }

  func mapAction(is action: RealmMapAction) {
    mapActionService.mapAction(is: action)
  }

  func getLocalMaps() -> [RealmMapModelData]? {
    guard let realm = realm else { return nil }
    let maps = realm.objects(RealmMapModelData.self)
    return Array(maps)
  }

  func removeAllLocalMaps() {
    guard let realm = realm else { return }
    realm.safeWrite {
      realm.deleteAll()
    }
  }
}
