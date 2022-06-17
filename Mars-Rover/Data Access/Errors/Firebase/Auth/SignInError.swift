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
  var localizedDescription: String {
    switch self {
    case .error(let error): return error
    case .absentOfUser: return L10n.Network.Error.Firebase.SignIn.absentOfUser
    case .notVerifiedEmail: return L10n.Network.Error.Firebase.SignIn.notVerifiedEmail
    case .notSignedIn: return L10n.Network.Error.Firebase.SignIn.notSignedIn
    }
  }
}
