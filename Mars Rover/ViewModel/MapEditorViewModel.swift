//
//  MapEditorViewModel.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

import Foundation

class MapEditorViewModel {
  private let syncService: MapsSyncService
  private let journalService: MapsJournalService
  private let realmService: RealmMapsServce
  var maps: Box<[RealmMapModelData]>
  var isUpdated: Box<Bool>

  init() {
    let journalService = MapsJournalService()
    let realmService = RealmMapsServce(mapActionService: RealmMapsActionService())
    self.journalService = journalService
    self.realmService = realmService
    self.syncService = MapsSyncService(
      realmMapService: realmService,
      firebaseMapService: FirebaseMapsServce(mapActionService: FirebaseMapsActionService()),
      journalService: journalService)
    self.maps = Box([RealmMapModelData]())
    self.isUpdated = Box(false)
  }

  func getLocalMaps() {
    self.maps.value.removeAll()
    let maps = realmService.getLocalMaps()
    guard let maps = maps else { return }
    self.maps.value = maps
  }

  func mapAction(action: RealmMapAction) {
    realmService.mapAction(is: action)
    journalService.journal(action: action)
    getLocalMaps()
  }

  func syncMaps() {
    maps.value.removeAll()
    syncService.sync { isUpdated in
      if isUpdated { self.isUpdated.value = true }
    }
  }
}
