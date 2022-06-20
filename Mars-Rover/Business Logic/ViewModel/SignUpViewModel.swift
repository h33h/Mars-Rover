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
  private(set) lazy var signUpError: Box<Error?> = Box(nil)

  func createAccount(signUpType: SignUpType) {
    authService?.signUp(with: signUpType) { [weak self] error in
      self?.signUpError.value = error
    }
  }
}
