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
  func sync(completion: @escaping FirebaseMapActionCompletion)
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

  func sync(completion: @escaping FirebaseMapActionCompletion) {
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
          guard let map = map.convertToRealmMap() else { return }
          self?.realmMapService.mapAction(is: .add(map: map))
        }
        return completion(nil)
      }
    }
  }

  private func syncAddedMaps(journalService: MapsJournalServiceProtocol, errorHandler: @escaping FirebaseMapActionCompletion) {
    for map in journalService.mapsToAdd {
      guard let map = map.convertToFirebaseMap() else { return }
      firebaseMapService.mapAction(is: .add(map: map), errorHandler: errorHandler)
    }
  }

  private func syncUpdatedMaps(journalService: MapsJournalServiceProtocol, errorHandler: @escaping FirebaseMapActionCompletion) {
    for map in journalService.mapsToEdit {
      guard let map = map.convertToFirebaseMap() else { return }
      firebaseMapService.mapAction(is: .edit(map: map), errorHandler: errorHandler)
    }
  }

  private func syncDeletedMaps(journalService: MapsJournalServiceProtocol, errorHandler: @escaping FirebaseMapActionCompletion) {
    for map in journalService.mapsToRemove {
      guard let map = map.convertToFirebaseMap() else { return }
      firebaseMapService.mapAction(is: .remove(map: map), errorHandler: errorHandler)
    }
  }
}
