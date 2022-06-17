//
//  MapsJournalService.swift
//  Mars Rover
//
//  Created by XXX on 13.11.21.
//

protocol MapsJournalServiceProtocol {
  var mapsToAdd: [RealmMap?] { get }
  var mapsToEdit: [RealmMap?] { get }
  var mapsToRemove: [RealmMap?] { get }
  func journal(action: RealmMapAction)
  func clearJournal()
}

final class MapsJournalService: MapsJournalServiceProtocol {
  private(set) var mapsToAdd: [RealmMap?] = []
  private(set) var mapsToEdit: [RealmMap?] = []
  private(set) var mapsToRemove: [RealmMap?] = []

  func journal(action: RealmMapAction) {
    switch action {
    case .add(let map): added(map: map)
    case .edit(let map): edited(map: map)
    case .remove(let map): removed(map: map)
    }
  }

  private func added(map: RealmMap) {
    mapsToAdd.append(map.copy() as? RealmMap)
  }

  private func edited(map: RealmMap) {
    mapsToEdit.append(map.copy() as? RealmMap)
  }

  private func removed(map: RealmMap) {
    mapsToAdd.removeAll { $0?.id == map.id }
    mapsToEdit.removeAll { $0?.id == map.id }
    mapsToRemove.append(map.copy() as? RealmMap)
  }

  func clearJournal() {
    mapsToAdd.removeAll()
    mapsToEdit.removeAll()
    mapsToRemove.removeAll()
  }
}
