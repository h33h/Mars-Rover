//
//  MainMenuViewModel.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import Foundation

class MainMenuViewModel {
  // MARK: - MainMenuViewModel: Variables
    private var authService = FirebaseAuthService(
      signInService: FirebaseSignInService(),
      signUpService: FirebaseSignUpService()
    )
    private var profileService = FirebaseProfileService(
      profileFetchService: FirebaseProfileFetchService(),
      profileWriteService: FirebaseProfileWriteService()
    )
    private let realmSevice = RealmMapsServce(mapActionService: RealmMapsActionService())
    var fetchError = Box("")
    var profileFetched = Box(ProfileModel(username: "Loading..."))
    var signOutError = Box("")
    var isSignedOut = Box(false)

  // MARK: - MainMenuViewModel: Methods
    func getProfile() {
      profileService.profileFetchService.fetch { [weak self] profile, error in
        guard let strongSelf = self else { return }
          if let error = error {
            switch error {
            case .error(error: let error):
              strongSelf.fetchError.value = error
            case .notSignedIn:
              strongSelf.fetchError.value = "Authentication error"
            case .profileNotExist:
              strongSelf.fetchError.value = "Profile not exist"
            }
            return
          }
          guard let profile = profile else {
            strongSelf.fetchError.value = "Unknown error"
              return
          }
          strongSelf.profileFetched.value = profile
      }
    }

  func setupNewUser() {
    profileService.profileWriteService.profileAction(action: .setupNewProfile) { [weak self] isCreated, error in
      guard let strongSelf = self else { return }
      if let error = error {
        switch error {
        case .error(let error):
          strongSelf.fetchError.value = error
        case .profileNotExist:
          strongSelf.fetchError.value = "Profile not exist"
        case .notSignedIn:
          strongSelf.fetchError.value = "Authentication error"
        }
        return
      }
      if isCreated {
        self?.getProfile()
      }
    }
  }

    func signOut() {
      authService.signOut { [weak self] error in
        guard let strongSelf = self else { return }
          if let error = error {
            strongSelf.signOutError.value = error.localizedDescription
              return
          }
        strongSelf.realmSevice.removeAllLocalMaps()
        strongSelf.isSignedOut.value = true
      }
    }
}
