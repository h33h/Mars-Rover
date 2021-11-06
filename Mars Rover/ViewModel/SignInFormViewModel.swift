//
//  SignInFormPresenter.swift
//  Mars Rover
//
//  Created by XXX on 2.11.21.
//

import Foundation

class SignInFormViewModel {
  // MARK: - SignInFormPresenter: Variables
    private var authService = FirebaseAuthService()
    var signInError = Box("")
    var isSignedIn = Box(false)


  // MARK: - SignInFormPresenter: Methods
  // SignIn function will call some sign In methods from service
    func signIn(signInType: SignInType) {
      authService.signIn(signInType: signInType) { [weak self] isSignedIn, error in
        guard let strongSelf = self else { return }
          if let error = error {
            switch error {
            case .error(error: let error):
              strongSelf.signInError.value = error
            case .absentOfUser:
              strongSelf.signInError.value = "No user found"
            case .notVerifiedEmail:
              strongSelf.signInError.value = "Your's email is not verified"
            case .unknownError:
              strongSelf.signInError.value = "Unknown error"
            case .notSignedIn:
              strongSelf.signInError.value = String()
            }
            strongSelf.isSignedIn.value = false
            return
          }
        if isSignedIn {
          strongSelf.isSignedIn.value = true
        } else {
          strongSelf.signInError.value = "Unknown error"
          strongSelf.isSignedIn.value = false
        }
      }
    }
}
