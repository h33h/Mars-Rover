//
//  String+Extensions.swift
//  Mars Rover
//
//  Created by XXX on 17.06.22.
//

import Foundation

extension String {
  var localized: String {
    // swiftlint: disable nslocalizedstring_key
    NSLocalizedString(self, comment: "")
  }
}
