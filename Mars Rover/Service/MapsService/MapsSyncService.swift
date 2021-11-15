//
//  RealmFirebaseMapsService.swift
//  Mars Rover
//
//  Created by XXX on 12.11.21.
//

import Foundation
import RealmSwift
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

class MapsSyncService {
  private let firebaseMapService: FirebaseMapsServceProtocol
  private let realmMapService: RealmMapsServceProtocol
  private let journalService: MapsJournalServiceProtocol
  private let queue = DispatchQueue(label: "sync")

  init(realmMapService: RealmMapsServceProtocol, firebaseMapService: FirebaseMapsServceProtocol, journalService: MapsJournalServiceProtocol) {
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

  func syncAddedMaps(journalService: MapsJournalServiceProtocol, errorHandler: @escaping FirebaseMapsServceErrorCompletion) {
    for map in journalService.addJournal {
      guard let map = map.convertToFirebaseMapModelData() else { return }
      firebaseMapService.mapAction(is: .addMap(map), errorHandler: errorHandler)
    }
  }

  func syncUpdatedMaps(journalService: MapsJournalServiceProtocol, errorHandler: @escaping FirebaseMapsServceErrorCompletion) {
    for map in journalService.updateJournal {
      guard let map = map.convertToFirebaseMapModelData() else { return }
      firebaseMapService.mapAction(is: .editMap(map), errorHandler: errorHandler)
    }
  }

  func syncDeletedMaps(journalService: MapsJournalServiceProtocol, errorHandler: @escaping FirebaseMapsServceErrorCompletion) {
    for mapId in journalService.deleteJournal {
      firebaseMapService.mapAction(is: .removeMap(mapId), errorHandler: errorHandler)
    }
  }
}
