//
//  MainMenuPresenter.swift
//  Mars Rover
//
//  Created by XXX on 1.11.21.
//

import Foundation

protocol MainMenuPresenterDelegate: AnyObject {
    func logoutAction()
    func logoutError(error: String)
    func profileGet(profile: ProfileModel)
    func profileGetFailure(error: String)
}

class MainMenuPresenter {
    private weak var delegate: MainMenuPresenterDelegate?
    private var authService = FirebaseAuthService()
    func setDelegate(delegate: MainMenuPresenterDelegate) {
        self.delegate = delegate
    }
    func getProfile() {
        authService.login(loginType: .checkLogin) { [weak self] profile, error in
            if let error = error {
                switch error {
                case .error(let error):
                    self?.delegate?.profileGetFailure(error: error)
                case .absentOfUser:
                    self?.delegate?.profileGetFailure(error: "User is missed")
                case .absentOfProfile:
                    self?.delegate?.profileGetFailure(error: "No profile")
                case .profileFetchError:
                    self?.delegate?.profileGetFailure(error: "Fetch profile error")
                case .notVerifiedEmail:
                    self?.delegate?.profileGetFailure(error: "Email is not verified")
                }
                return
            }
            guard let profile = profile else {
                self?.delegate?.profileGetFailure(error: "No Profile")
                return
            }
            self?.delegate?.profileGet(profile: profile)
        }
    }
    func logout() {
        authService.logout { [weak self] error in
            if let error = error {
                self?.delegate?.logoutError(error: error.localizedDescription)
                return
            }
            self?.delegate?.logoutAction()
        }
    }
}
