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
    case .notSignedIn: return "User not signed in"
    case .fetchFirebaseError: return "Map list getting error"
    case .mapNotExist: return "Map does not exist"
    case .error(let error): return error
    }
  }
}
