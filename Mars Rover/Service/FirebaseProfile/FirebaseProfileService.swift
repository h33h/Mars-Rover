//
//  FirebaseProfileService.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import Foundation

class FirebaseProfileService {
  // MARK: - FirebaseAuthService: Variables
    public var profileFetchService: ProfileFetchProtocol
    public var profileWriteService: ProfileWriteProtocol

  // MARK: - FirebaseAuthService: Init Methods
    init(profileFetchService: ProfileFetchProtocol, profileWriteService: ProfileWriteProtocol) {
      self.profileFetchService = profileFetchService
      self.profileWriteService = profileWriteService
    }
}
