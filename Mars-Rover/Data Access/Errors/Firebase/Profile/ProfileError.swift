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
  var localizedDescription: String {
    switch self {
    case .error(let error): return error
    case .profileNotExist: return "Profile does not exist"
    case .notSignedIn: return "User not signed in"
    }
  }
}
