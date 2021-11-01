//
//  LoginFormPresenter.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import Foundation

protocol LoginFormPresenterDelegate: AnyObject {
    func successfullLogin(profile: ProfileModel)
    func failureLogin(error: String)
}

class LoginFormPresenter {
    private weak var delegate: LoginFormPresenterDelegate?
    private var authService = FirebaseAuthService()
    func setDelegate(delegate: LoginFormPresenterDelegate) {
        self.delegate = delegate
    }
    func login(loginType: LoginType) {
        authService.login(loginType: loginType) { [weak self] profile, error in
            if let error = error {
                switch error {
                case .error(let description):
                    self?.delegate?.failureLogin(error: description)
                case .absentOfUser:
                    self?.delegate?.failureLogin(error: "User is missed")
                case .absentOfProfile:
                    self?.delegate?.failureLogin(error: "No profile")
                case .profileFetchError:
                    self?.delegate?.failureLogin(error: "Fetch profile error")
                case .notVerifiedEmail:
                    self?.delegate?.failureLogin(error: "Email is not verified")
                }
            }
            guard let profile = profile else { return }
            self?.delegate?.successfullLogin(profile: profile)
        }
    }
}
