//
//  SignInFormPresenter.swift
//  Mars Rover
//
//  Created by XXX on 2.11.21.
//

import Foundation

protocol SignInFormPresenterDelegate: AnyObject {

    // MARK: - SignInFormPresenterDelegate: Delegate Methods
    func successfullSignIn()

    func failureSignIn(error: String)

}

class SignInFormPresenter {

    // MARK: - SignInFormPresenter: Variables
    private weak var delegate: SignInFormPresenterDelegate?
    private var authService = FirebaseAuthService()

    // MARK: - SignInFormPresenter: Methods
    func setDelegate(delegate: SignInFormPresenterDelegate) {
        self.delegate = delegate
    }

    // SignIn function will call some sign In methods from service
    func signIn(signInType: SignInType) {
        authService.signIn(signInType: signInType) { [weak self] isSignedIn, error in
            guard let strongSelf = self else { return }
            if let error = error {
                switch error {
                case .error(error: let error):
                    strongSelf.delegate?.failureSignIn(error: error)
                case .absentOfUser:
                    strongSelf.delegate?.failureSignIn(error: "No user found")
                case .notVerifiedEmail:
                    strongSelf.delegate?.failureSignIn(error: "Your's email is not verified")
                case .unknownError:
                    strongSelf.delegate?.failureSignIn(error: "Unknown error")
                case .notSignedIn:
                    strongSelf.delegate?.failureSignIn(error: String())
                }
                return
            }
            if isSignedIn {
                strongSelf.delegate?.successfullSignIn()
            } else {
                strongSelf.delegate?.failureSignIn(error: "Unknown error")
            }
        }
    }

}
