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
    // swiftlint:disable first_where
    let object = realm
      .objects(RealmMap.self)
      .filter(L10n.Network.RealmMap.filter(map.id))
      .first

    realm.safeWrite {
      if let object = object {
        object.label = map.label
        object.lastEdited = Date()
        object.mapContent = map.mapContent
      }
    }
  }

  private func remove(map: RealmMap) {
    guard let realm = realm else { return }

    guard
      // swiftlint:disable first_where
      let object = realm
        .objects(RealmMap.self)
        .filter(L10n.Network.RealmMap.filter(map.id))
        .first
    else { return }

    realm.safeWrite {
      realm.delete(map.mapContent)
      realm.delete(object)
    }
  }
}
