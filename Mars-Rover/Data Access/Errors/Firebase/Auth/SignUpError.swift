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
  var localizedDescription: String {
    switch self {
    case .error(let error): return error
    case .absentOfUser: return "Empty user data"
    }
  }
}
