//
//  RealmMapsActionServiceProtocol.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

enum RealmMapAction {
  case add(map: RealmMap)
  case edit(map: RealmMap)
  case remove(map: RealmMap)
}

protocol RealmMapsActionServiceProtocol {
  func mapAction(is action: RealmMapAction)
}
