//
//  MainMenuViewModel.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import Foundation

class MainMenuViewModel {
  // MARK: - MainMenuViewModel: Variables
    let authService: FirebaseAuthServiceProtocol
    let profileService: FirebaseProfileServiceProtocol
    let realmSevice: RealmMapsServceProtocol
    var errorMessage: Box<String>
    var profile: Box<ProfileModel>
    var isSignedOut: Box<Bool>

  init(authService: FirebaseAuthServiceProtocol, profileService: FirebaseProfileServiceProtocol, realmMapsService: RealmMapsServceProtocol) {
    self.authService = authService
    self.profileService = profileService
    self.realmSevice = realmMapsService
    self.errorMessage = Box("")
    self.profile = Box(ProfileModel(username: "Loading..."))
    self.isSignedOut = Box(false)
  }

  // MARK: - MainMenuViewModel: Methods
    func getProfile() {
      profileService.fetch { [weak self] profile, error in
        guard let this = self else { return }
          if let error = error {
            switch error {
            case .error(error: let error):
              this.errorMessage.value = error
            case .notSignedIn:
              this.errorMessage.value = "Authentication error"
            case .profileNotExist:
              this.errorMessage.value = "Profile not exist"
            }
            return
          }
          guard let profile = profile else {
            this.errorMessage.value = "Unknown error"
              return
          }
        this.profile.value = profile
      }
    }

  func setupNewUser() {
    profileService.profileAction(action: .setupNewProfile) { [weak self] error in
      guard let this = self else { return }
      if let error = error {
        switch error {
        case .error(let error):
          this.errorMessage.value = error
        case .profileNotExist:
          this.errorMessage.value = "Profile not exist"
        case .notSignedIn:
          this.errorMessage.value = "Authentication error"
        }
        return
      }
      this.getProfile()
    }
  }

    func signOut() {
      authService.signOut { [weak self] error in
        guard let this = self else { return }
          if let error = error {
            this.errorMessage.value = error.localizedDescription
              return
          }
        this.realmSevice.removeAllLocalMaps()
        this.isSignedOut.value = true
      }
    }
}
