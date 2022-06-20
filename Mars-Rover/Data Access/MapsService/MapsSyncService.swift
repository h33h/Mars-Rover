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
  var firebaseMapService: FirebaseMapsServiceProtocol?
  var realmMapService: RealmMapsServiceProtocol?
  var journalService: MapsJournalServiceProtocol?
  private let queue = DispatchQueue(label: L10n.Network.MapSync.sync)

  func sync(completion: @escaping FirebaseMapActionCompletion) {
    queue.sync {
      syncAddedMaps { completion($0) }
    }
    queue.sync {
      syncUpdatedMaps { completion($0) }
    }
    queue.sync {
      syncDeletedMaps { completion($0) }
    }
    queue.sync {
      journalService?.clearJournal()
      realmMapService?.removeAllLocalMaps()
    }
    queue.sync {
      firebaseMapService?.getMaps { [weak self] maps, error in
        if let error = error {
          return completion(error)
        }
        guard let maps = maps else { return }
        for map in maps {
          self?.realmMapService?.mapAction(is: .add(map: map.convertToRealmMap()))
        }
        return completion(nil)
      }
    }
  }

  private func syncAddedMaps(errorHandler: @escaping FirebaseMapActionCompletion) {
    journalService?.mapsToAdd
      .compactMap { $0 }
      .forEach {
        firebaseMapService?.mapAction(is: .add(map: $0.convertToFirebaseMap()), errorHandler: errorHandler)
      }
  }

  private func syncUpdatedMaps(errorHandler: @escaping FirebaseMapActionCompletion) {
    journalService?.mapsToEdit
      .compactMap { $0 }
      .forEach {
        firebaseMapService?.mapAction(is: .edit(map: $0.convertToFirebaseMap()), errorHandler: errorHandler)
      }
  }

  private func syncDeletedMaps(errorHandler: @escaping FirebaseMapActionCompletion) {
    journalService?.mapsToRemove
      .compactMap { $0 }
      .forEach {
        firebaseMapService?.mapAction(is: .remove(map: $0.convertToFirebaseMap()), errorHandler: errorHandler)
      }
  }
}
