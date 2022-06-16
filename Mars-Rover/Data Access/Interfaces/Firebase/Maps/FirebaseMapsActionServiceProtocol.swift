//
//  FirebaseMapsActionServiceProtocol.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

enum FirebaseMapAction {
  case add(map: FirebaseMap)
  case edit(map: FirebaseMap)
  case remove(map: FirebaseMap)
}

protocol FirebaseMapsActionServiceProtocol {
  func mapAction(is action: FirebaseMapAction, errorHandler: @escaping FirebaseMapActionCompletion)
}
