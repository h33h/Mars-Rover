//
//  MapEditorViewModel.swift
//  Mars Rover
//
//  Created by XXX on 10.11.21.
//

class MapEditorViewModel {
  weak var coordinator: MapEditorFlow?
  var syncService: MapsSyncServiceProtocol?
  var journalService: MapsJournalServiceProtocol?
  var realmService: RealmMapsServiceProtocol?
  private(set) lazy var maps: Box<[RealmMap]> = Box([RealmMap]())
  private(set) lazy var mapsError: Box<Error?> = Box(nil)

  func getLocalMaps() {
    self.maps.value.removeAll()
    let maps = realmService?.getLocalMaps()
    guard let maps = maps else { return }
    self.maps.value = maps.sorted { map1, map2 in
      map1.lastEdited > map2.lastEdited
    }
  }

  func mapAction(action: RealmMapAction) {
    journalService?.journal(action: action)
    realmService?.mapAction(is: action)
  }

  func syncMaps() {
    maps.value.removeAll()
    syncService?.sync { [weak self] error in
      self?.mapsError.value = error
      self?.getLocalMaps()
    }
  }
}
