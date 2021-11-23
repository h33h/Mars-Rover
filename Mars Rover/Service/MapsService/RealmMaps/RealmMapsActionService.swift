//
//  RealmMapsSaveService.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import Foundation
import RealmSwift

enum RealmMapAction {
  case addMap(RealmMapModelData)
  case editMap(RealmMapModelData)
  case removeMap(ObjectId)
}

protocol RealmMapsActionServiceProtocol {
  func mapAction(is action: RealmMapAction)
}

final class RealmMapsActionService: RealmMapsActionServiceProtocol {
  let realm: Realm? = Realm.safeInit()

  func mapAction(is action: RealmMapAction) {
    switch action {
    case let .addMap(mapModel):
      addMap(mapModel: mapModel)
    case let .editMap(mapModel):
      editMap(mapModel: mapModel)
    case let .removeMap(mapId):
      removeMap(withId: mapId)
    }
  }

  private func addMap(mapModel: RealmMapModelData) {
    guard let realm = realm else { return }
    realm.safeWrite {
      realm.add(mapModel)
    }
  }

  private func editMap(mapModel: RealmMapModelData) {
    guard let realm = realm else { return }
      let object = realm.objects(RealmMapModelData.self).filter("id = %@", mapModel.id).first
      realm.safeWrite {
        if let object = object {
          object.mapLabel = mapModel.mapLabel
          object.lastEdited = Date()
          object.map = mapModel.map
        }
      }
  }

  private func removeMap(withId mapId: ObjectId) {
    guard let realm = realm else { return }
    guard
      let object = realm.objects(RealmMapModelData.self).filter("id = %@", mapId).first,
      let map = object.map
    else { return }
    realm.safeWrite {
      realm.delete(map)
      realm.delete(object)
    }
  }
}
