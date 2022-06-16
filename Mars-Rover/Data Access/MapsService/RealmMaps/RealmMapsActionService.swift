//
//  RealmMapsSaveService.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import RealmSwift

final class RealmMapsActionService: RealmMapsActionServiceProtocol {
  private let realm: Realm? = Realm.safeInit()

  func mapAction(is action: RealmMapAction) {
    switch action {
    case let .add(map):
      add(map: map)
    case let .edit(map):
      edit(map: map)
    case let .remove(map):
      remove(map: map)
    }
  }

  private func add(map: RealmMap) {
    guard let realm = realm else { return }

    realm.safeWrite {
      realm.add(map)
    }
  }

  private func edit(map: RealmMap) {
    guard let realm = realm else { return }

    let object = realm
      .objects(RealmMap.self)
      .filter("id = %@", map.id)
      .first

    realm.safeWrite {
      if let object = object {
        object.mapLabel = map.mapLabel
        object.lastEdited = Date()
        object.mapContent = map.mapContent
      }
    }
  }

  private func remove(map: RealmMap) {
    guard let realm = realm else { return }

    guard
      let object = realm
        .objects(RealmMap.self)
        .filter("id = %@", map.id)
        .first,
      let map = object.mapContent
    else { return }

    realm.safeWrite {
      realm.delete(map)
      realm.delete(object)
    }
  }
}
