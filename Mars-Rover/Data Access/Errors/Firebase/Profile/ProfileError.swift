//
//  ProfileError.swift
//  Mars Rover
//
//  Created by XXX on 15.06.22.
//

import Foundation

public enum ProfileError: LocalizedError {
  case error(String)
  case profileNotExist
  case notSignedIn
}

extension ProfileError {
  var errorDescription: String? {
    switch self {
    case .error(let error): return error.localized
    case .profileNotExist: return L10n.Network.Error.Firebase.Profile.profileNotExist.localized
    case .notSignedIn: return L10n.Network.Error.Firebase.Profile.notSignedIn.localized
    }
  }
}
