//
//  Realm+Extensions.swift
//  Mars Rover
//
//  Created by XXX on 13.11.21.
//

import RealmSwift

extension Realm {
  static func safeInit() -> Realm? {
    do {
      let realm = try Realm()
      return realm
    } catch {
      print(error.localizedDescription)
    }
    return nil
  }

  func safeWrite(_ block: () -> Void) {
    do {
      if !isInWriteTransaction {
        try write(block)
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}
