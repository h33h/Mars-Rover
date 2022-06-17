//
//  FirebaseMapsServiceError.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Foundation

enum FirebaseMapsServiceError: LocalizedError {
  case notSignedIn
  case fetchFirebaseError
  case mapNotExist
  case error(String)
}

extension FirebaseMapsServiceError {
  var errorDescription: String? {
    switch self {
    case .notSignedIn:
      return L10n.Network.Error.Firebase.Maps.notSignedIn.localized
    case .fetchFirebaseError:
      return L10n.Network.Error.Firebase.Maps.fetchFirebaseError.localized
    case .mapNotExist:
      return L10n.Network.Error.Firebase.Maps.mapNotExist.localized
    case .error(let error): return error.localized
    }
  }
}
