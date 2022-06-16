//
//  MapsJournalService.swift
//  Mars Rover
//
//  Created by XXX on 13.11.21.
//

import Foundation

protocol MapsJournalServiceProtocol {
  var mapsToAdd: [RealmMap] { get }
  var mapsToEdit: [RealmMap] { get }
  var mapsToRemove: [RealmMap] { get }
  func journal(action: RealmMapAction)
  func clearJournal()
}

final class MapsJournalService: MapsJournalServiceProtocol {
  static var shared = MapsJournalService()
  private(set) var mapsToAdd: [RealmMap] = []
  private(set) var mapsToEdit: [RealmMap] = []
  private(set) var mapsToRemove: [RealmMap] = []

  func journal(action: RealmMapAction) {
    switch action {
    case .add(let map): added(map: map)
    case .edit(let map): edited(map: map)
    case .remove(let map): removed(map: map)
    }
  }

  private func added(map: RealmMap) {
    mapsToAdd.append(map)
  }

  private func edited(map: RealmMap) {
    mapsToEdit.append(map)
  }

  private func removed(map: RealmMap) {
    mapsToAdd.removeAll { $0 == map }
    mapsToEdit.removeAll { $0 == map }
    mapsToRemove.append(map)
  }

  func clearJournal() {
    mapsToAdd.removeAll()
    mapsToEdit.removeAll()
    mapsToRemove.removeAll()
  }
}
