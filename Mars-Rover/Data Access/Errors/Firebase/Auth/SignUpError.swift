//
//  SignUpError.swift
//  Mars Rover
//
//  Created by XXX on 15.06.22.
//

import Foundation

enum SignUpError: LocalizedError {
  case error(String)
  case absentOfUser
}

extension SignUpError {
  var errorDescription: String? {
    switch self {
    case .error(let error): return error.localized
    case .absentOfUser:
      return L10n.Network.Error.Firebase.SignUp.absentOfUser.localized
    }
  }
}
