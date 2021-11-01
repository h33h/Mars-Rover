//
//  RegisterFormPresenter.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import Foundation

protocol RegisterFormPresenterDelegate: AnyObject {
    func successfullRegistration()
    func failureRegistration(error: String)
}

class RegisterFormPresenter {
    private weak var delegate: RegisterFormPresenterDelegate?
    private var authService = FirebaseAuthService()
    func setDelegate(delegate: RegisterFormPresenterDelegate) {
        self.delegate = delegate
    }
    func createAccount(registerType: RegisterType) {
        authService.register(registerType: registerType) { [weak self] result, error in
            guard let result = result else {
                if let error = error {
                    switch error {
                    case .error(error: let error):
                        self?.delegate?.failureRegistration(error: error)
                    case .absentOfUser:
                        self?.delegate?.failureRegistration(error: "User is missed")
                    case .noEmail:
                        self?.delegate?.failureRegistration(error: "Absent of Email")
                    }
                }
                self?.delegate?.failureRegistration(error: "Registration failed")
                return
            }
            if result {
                self?.delegate?.successfullRegistration()
            } else {
                self?.delegate?.failureRegistration(error: "Registration failed")
            }
        }
    }
}
