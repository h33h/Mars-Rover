//
//  SignInError.swift
//  Mars Rover
//
//  Created by XXX on 15.06.22.
//

import Foundation

enum SignInError: LocalizedError {
  case error(String)
  case absentOfUser
  case notVerifiedEmail
  case notSignedIn
}

extension SignInError {
  var errorDescription: String? {
    switch self {
    case .error(let error): return error.localized
    case .absentOfUser:
      return L10n.Network.Error.Firebase.SignIn.absentOfUser.localized
    case .notVerifiedEmail:
      return L10n.Network.Error.Firebase.SignIn.notVerifiedEmail.localized
    case .notSignedIn:
      return L10n.Network.Error.Firebase.SignIn.notSignedIn.localized
    }
  }
}
