//
//  RealmFirebaseMapsService.swift
//  Mars Rover
//
//  Created by XXX on 12.11.21.
//

import RealmSwift
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

protocol MapsSyncServiceProtocol {
  func sync(completion: @escaping FirebaseMapsServceErrorCompletion)
}

final class MapsSyncService: MapsSyncServiceProtocol {
  static var shared = MapsSyncService(
    realmMapService: RealmMapsService.shared,
    firebaseMapService: FirebaseMapsService.shared,
    journalService: MapsJournalService.shared
  )
  let firebaseMapService: FirebaseMapsServiceProtocol
  let realmMapService: RealmMapsServiceProtocol
  let journalService: MapsJournalServiceProtocol
  private let queue = DispatchQueue(label: "sync")

  init(realmMapService: RealmMapsServiceProtocol, firebaseMapService: FirebaseMapsServiceProtocol, journalService: MapsJournalServiceProtocol) {
    self.realmMapService = realmMapService
    self.firebaseMapService = firebaseMapService
    self.journalService = journalService
  }

  func sync(completion: @escaping FirebaseMapsServceErrorCompletion) {
    queue.sync {
      syncAddedMaps(journalService: journalService) { error in
        if let error = error {
          return completion(error)
        }
      }
    }
    queue.sync {
      syncUpdatedMaps(journalService: journalService) { error in
        if let error = error {
          return completion(error)
        }
      }
    }
    queue.sync {
      syncDeletedMaps(journalService: journalService) { error in
        if let error = error {
          return completion(error)
        }
      }
    }
    queue.sync {
      journalService.clearJournal()
      realmMapService.removeAllLocalMaps()
    }
    queue.sync {
      firebaseMapService.getMaps { [weak self] maps, error in
        if let error = error {
          print(error)
          return
        }
        guard let maps = maps else { return }
        for map in maps {
          guard let map = map.convertToRealmMapModelData() else { return }
          self?.realmMapService.mapAction(is: .addMap(map))
        }
        return completion(nil)
      }
    }
  }

  private func syncAddedMaps(journalService: MapsJournalServiceProtocol, errorHandler: @escaping FirebaseMapsServceErrorCompletion) {
    for map in journalService.mapsToAdd {
      guard let map = map.convertToFirebaseMapModelData() else { return }
      firebaseMapService.mapAction(is: .addMap(map), errorHandler: errorHandler)
    }
  }

  private func syncUpdatedMaps(journalService: MapsJournalServiceProtocol, errorHandler: @escaping FirebaseMapsServceErrorCompletion) {
    for map in journalService.mapsToUpdate {
      guard let map = map.convertToFirebaseMapModelData() else { return }
      firebaseMapService.mapAction(is: .editMap(map), errorHandler: errorHandler)
    }
  }

  private func syncDeletedMaps(journalService: MapsJournalServiceProtocol, errorHandler: @escaping FirebaseMapsServceErrorCompletion) {
    for mapId in journalService.mapsIdToDelete {
      firebaseMapService.mapAction(is: .removeMap(mapId), errorHandler: errorHandler)
    }
  }
}
