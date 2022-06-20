//
//  SignInViewModel.swift
//  Mars Rover
//
//  Created by XXX on 2.11.21.
//

class SignInViewModel {
  weak var coordinator: SignInFlow?
  var authService: FirebaseAuthServiceProtocol?
  private(set) lazy var signInError: Box<Error?> = Box(nil)

  func signIn(signInType: SignInType) {
    authService?.signIn(with: signInType) { [weak self] error in
      self?.signInError.value = error
    }
  }
}
