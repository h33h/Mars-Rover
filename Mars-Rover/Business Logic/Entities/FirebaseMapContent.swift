//
//  FirebaseMapContent.swift
//  Mars Rover
//
//  Created by XXX on 13.11.21.
//

struct FirebaseMapContent: Codable {
  private(set) var size: MapSize
  private(set) var map: [Int]
}

extension FirebaseMapContent {
  func convertToRealmMapContent() -> RealmMapContent {
    RealmMapContent(size: size, map: map)
  }
}
