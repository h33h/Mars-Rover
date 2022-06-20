//
//  FirebaseProfileServiceProtocol.swift
//  Mars Rover
//
//  Created by XXX on 15.06.22.
//

public enum ProfileActionType {
  case setupNewProfile
}

typealias FetchProfileCompletion = (Profile?, ProfileError?) -> Void
typealias WriteProfileCompletion = (ProfileError?) -> Void

protocol FirebaseProfileServiceProtocol {
  func fetch(completion: @escaping FetchProfileCompletion)
  func profileAction(action: ProfileActionType, completion: @escaping WriteProfileCompletion)
}
