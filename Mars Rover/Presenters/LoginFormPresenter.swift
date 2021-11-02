//
//  LoginFormPresenter.swift
//  Mars Rover
//
//  Created by XXX on 2.11.21.
//

import Foundation

protocol LoginFormPresenterDelegate: AnyObject {

    // MARK: - LoginFormPresenterDelegate: Delegate Methods
    func successfullLogin()
    func failureLogin(error: String)
}

class LoginFormPresenter {

    // MARK: - LoginFormPresenter: Variables
    private weak var delegate: LoginFormPresenterDelegate?
}

extension LoginFormPresenter {
    // MARK: - LoginFormPresenter: Methods
    // Delegate setter method
    func setDelegate(delegate: LoginFormPresenterDelegate) {
        self.delegate = delegate
    }
    // Login function will call some sign In methods from service
    func login() {
    }
}
