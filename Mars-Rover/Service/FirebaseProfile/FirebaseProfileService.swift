//
//  FirebaseProfileService.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import Foundation

protocol FirebaseProfileServiceProtocol {
  func profileAction(action: ProfileActionType, completion: @escaping RWProfileCompletion)
  func fetch(completion: @escaping ProfileCompletion)
}

final class FirebaseProfileService: FirebaseProfileServiceProtocol {
  // MARK: - FirebaseAuthService: Variables
    static var shared = FirebaseProfileService(
      profileFetchService: FirebaseProfileFetchService(),
      profileWriteService: FirebaseProfileWriteService()
    )
    let profileFetchService: FirebaseProfileFetchServiceProtocol
    let profileWriteService: FirebaseProfileWriteServiceProtocol

  // MARK: - FirebaseAuthService: Init Methods
    init(profileFetchService: FirebaseProfileFetchServiceProtocol, profileWriteService: FirebaseProfileWriteServiceProtocol) {
      self.profileFetchService = profileFetchService
      self.profileWriteService = profileWriteService
    }

  // MARK: - FirebaseAuthService: Methods
    func profileAction(action: ProfileActionType, completion: @escaping RWProfileCompletion) {
      profileWriteService.profileAction(action: action, completion: completion)
    }

    func fetch(completion: @escaping ProfileCompletion) {
      profileFetchService.fetch(completion: completion)
    }
}
