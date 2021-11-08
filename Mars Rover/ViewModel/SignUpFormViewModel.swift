//
//  SignUpFormViewModel.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

class SignUpFormViewModel {
  // MARK: - SignUpFormPresenter: Variables
    private var authService = FirebaseAuthService(
      signInService: FirebaseSignInService(),
      signUpService: FirebaseSignUpService()
    )
    var signUpError = Box("")
    var isSignedUp = Box(false)

  // MARK: - SignUpFormPresenter: Methods
    func createAccount(signUpType: SignUpType) {
      authService.signUpService.signUp(with: signUpType) { [weak self] isSignedUp, error in
        guard let strongSelf = self else { return }
        if let error = error {
          switch error {
          case .error(error: let error):
            strongSelf.signUpError.value = error
          case .unknownError:
            strongSelf.signUpError.value = "Unknown error"
          case .absentOfUser:
            strongSelf.signUpError.value = "No user found"
          }
          return
        }
        if isSignedUp {
          strongSelf.isSignedUp.value = true
        } else {
          strongSelf.signUpError.value = "Unknown error"
          strongSelf.isSignedUp.value = false
        }
      }
    }
}
