//
//  MapEditorViewModel.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import Foundation

class MapEditorViewModel {
  // MARK: - MapEditorViewModel: Variables
  let syncService: MapsSyncServiceProtocol
  let journalService: MapsJournalServiceProtocol
  let realmService: RealmMapsServceProtocol
  var maps: Box<[RealmMapModelData]>
  var isUpdated: Box<Bool>

  // MARK: - MapEditorViewModel: Init
  init(journalService: MapsJournalServiceProtocol, realmMapsSevice: RealmMapsServceProtocol, syncService: MapsSyncServiceProtocol) {
    self.journalService = journalService
    self.realmService = realmMapsSevice
    self.syncService = syncService
    self.maps = Box([RealmMapModelData]())
    self.isUpdated = Box(false)
  }

  // MARK: - MapEditorViewModel: Methods

  func getLocalMaps() {
    self.maps.value.removeAll()
    let maps = realmService.getLocalMaps()
    guard let maps = maps else { return }
    self.maps.value = maps.sorted { map1, map2 in
      map1.lastEdited > map2.lastEdited
    }
  }

  func mapAction(action: RealmMapAction) {
    realmService.mapAction(is: action)
    journalService.journal(action: action)
    getLocalMaps()
  }

  func syncMaps() {
    maps.value.removeAll()
    syncService.sync { error in
      if let error = error {
        return print(error)
      }
      self.isUpdated.value = true
    }
  }
}
