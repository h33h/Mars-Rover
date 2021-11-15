//
//  MapsJournalService.swift
//  Mars Rover
//
//  Created by XXX on 13.11.21.
//

import Foundation

protocol MapsJournalServiceProtocol {
  var addJournal: [RealmMapModelData] { get }
  var updateJournal: [RealmMapModelData] { get }
  var deleteJournal: [String] { get }
  func clearJournal()
}

class MapsJournalService: MapsJournalServiceProtocol {
  private var mapsToAdd: [RealmMapModelData] = []
  private var mapsToUpdate: [RealmMapModelData] = []
  private var mapsIdToDelete: [String] = []

  var addJournal: [RealmMapModelData] {
    mapsToAdd
  }

  var updateJournal: [RealmMapModelData] {
    mapsToUpdate
  }

  var deleteJournal: [String] {
    mapsIdToDelete
  }

  func journal(action: RealmMapAction) {
    switch action {
    case .addMap(let realmMapModelData):
      mapAdded(map: realmMapModelData)
    case .editMap(let realmMapModelData):
      mapUpdated(map: realmMapModelData)
    case .removeMap(let mapId):
      mapDeleted(mapId: mapId.stringValue)
    }
  }

  func mapAdded(map: RealmMapModelData) {
    mapsToAdd.append(map)
  }

  func mapUpdated(map: RealmMapModelData) {
    mapsToUpdate.append(map)
  }

  func mapDeleted(mapId: String) {
    mapsIdToDelete.append(mapId)
    for (index, map) in mapsToAdd.enumerated() where map.id.stringValue == mapId {
      mapsToAdd.remove(at: index)
    }
    for (index, map) in mapsToUpdate.enumerated() where map.id.stringValue == mapId {
      mapsToUpdate.remove(at: index)
    }
  }

  func clearJournal() {
    mapsToAdd.removeAll()
    mapsToUpdate.removeAll()
    mapsIdToDelete.removeAll()
  }
}
