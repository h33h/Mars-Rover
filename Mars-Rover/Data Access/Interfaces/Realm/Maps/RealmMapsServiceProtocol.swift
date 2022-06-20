//
//  RealmMapsServiceProtocol.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

protocol RealmMapsServiceProtocol: RealmMapsActionServiceProtocol {
  func getLocalMaps() -> [RealmMap]?
  func removeAllLocalMaps()
}
