//
//  MapsJournalService.swift
//  Mars Rover
//
//  Created by XXX on 13.11.21.
//

import Foundation

protocol MapsJournalServiceProtocol {
  var mapsToAdd: [RealmMapModelData] { get }
  var mapsToUpdate: [RealmMapModelData] { get }
  var mapsIdToDelete: [String] { get }
  func journal(action: RealmMapAction)
  func clearJournal()
}

final class MapsJournalService: MapsJournalServiceProtocol {
  static var shared = MapsJournalService()
  private(set) var mapsToAdd: [RealmMapModelData] = []
  private(set) var mapsToUpdate: [RealmMapModelData] = []
  private(set) var mapsIdToDelete: [String] = []

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

  private func mapAdded(map: RealmMapModelData) {
    mapsToAdd.append(map)
  }

  private func mapUpdated(map: RealmMapModelData) {
    mapsToUpdate.append(map)
  }

  private func mapDeleted(mapId: String) {
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
