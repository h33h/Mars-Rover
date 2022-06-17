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
  var localizedDescription: String {
    switch self {
    case .notSignedIn: return L10n.Network.Error.Firebase.Maps.notSignedIn
    case .fetchFirebaseError: return L10n.Network.Error.Firebase.Maps.fetchFirebaseError
    case .mapNotExist: return L10n.Network.Error.Firebase.Maps.mapNotExist
    case .error(let error): return error
    }
  }
}
