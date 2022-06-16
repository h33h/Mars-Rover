//
//  SignUpFormViewModel.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

class SignUpFormViewModel {
  // MARK: - SignUpFormPresenter: Variables
    let authService: FirebaseAuthServiceProtocol
    private(set) var signUpError: Box<String>
    private(set) var isSignedUp: Box<Bool>

  init(authService: FirebaseAuthServiceProtocol) {
    self.authService = authService
    self.signUpError = Box("")
    self.isSignedUp = Box(false)
  }

  // MARK: - SignUpFormPresenter: Methods
    func createAccount(signUpType: SignUpType) {
      authService.signUp(with: signUpType) { [weak self] error in
        guard let this = self else { return }
        if let error = error {
          switch error {
          case .error(error: let error):
            this.signUpError.value = error
          case .absentOfUser:
            this.signUpError.value = "No user found"
          }
          return
        }
        this.isSignedUp.value = true
      }
    }
}
