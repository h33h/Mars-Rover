//
//  MainMenuViewModel.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

class MainMenuViewModel {
  weak var coordinator: MainMenuFlow?
  var authService: FirebaseAuthServiceProtocol?
  var profileService: FirebaseProfileServiceProtocol?
  private(set) lazy var profileResponse: Box<(Profile?, Error?)> = Box((nil, nil))
  private(set) lazy var signOutError: Box<Error?> = Box(nil)

  func getProfile() {
    profileService?.fetch { [weak self] profile, error in
      self?.profileResponse.value = (profile, error)
    }
  }

  func signOut() {
    authService?.signOut { [weak self] error in
      self?.signOutError.value = error
    }
  }
}
