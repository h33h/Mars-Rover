//
//  SignUpViewModel.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

class SignUpViewModel {
  weak var coordinator: BackFlow?
  var authService: FirebaseAuthServiceProtocol?
  var profileService: FirebaseProfileServiceProtocol?
  private(set) lazy var signUpError: Box<Error?> = Box(nil)
  private(set) lazy var profileWriteError: Box<Error?> = Box(nil)

  func setupNewUser() {
    profileService?.profileAction(action: .setupNewProfile) { [weak self] error in
      self?.profileWriteError.value = error
    }
  }

  func createAccount(signUpType: SignUpType) {
    authService?.signUp(with: signUpType) { [weak self] error in
      self?.signUpError.value = error
      self?.setupNewUser()
    }
  }
}
