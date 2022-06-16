//
//  SignInFormPresenter.swift
//  Mars Rover
//
//  Created by XXX on 2.11.21.
//

import Foundation

class SignInFormViewModel {
  // MARK: - SignInFormPresenter: Variables
    let authService: FirebaseAuthServiceProtocol
    private(set) var signInError: Box<String>
    private(set) var isSignedIn: Box<Bool>

  init(authService: FirebaseAuthServiceProtocol) {
    self.authService = authService
    self.signInError = Box("")
    self.isSignedIn = Box(false)
  }

  // MARK: - SignInFormPresenter: Methods
  // SignIn function will call some sign In methods from service
    func signIn(signInType: SignInType) {
      authService.signIn(with: signInType) { [weak self] error in
        guard let this = self else { return }
          if let error = error {
            switch error {
            case .error(error: let error):
              this.signInError.value = error
            case .absentOfUser:
              this.signInError.value = "No user found"
            case .notVerifiedEmail:
              this.signInError.value = "Your's email is not verified"
            case .notSignedIn:
              this.signInError.value = String()
            }
            return
          }
        this.isSignedIn.value = true
      }
    }
}
