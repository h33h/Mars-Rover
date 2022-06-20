//
//  FindPathError.swift
//  Mars Rover
//
//  Created by XXX on 17.06.22.
//

import Foundation

enum FindPathError: LocalizedError {
  case impassable
}

extension FindPathError {
  var errorDescription: String? {
    switch self {
    case .impassable: return L10n.Algorithm.FindPathError.impassable.localized
    }
  }
}
