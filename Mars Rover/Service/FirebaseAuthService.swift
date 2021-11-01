//
//  FirebaseAuthService.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService {
    private let auth = Auth.auth()
    private var loginService = FirebaseLoginService()
    private var registerService = FirebaseRegisterService()
    func login(loginType: LoginType, completion: @escaping LoginProfileCompletion) {
        switch loginType {
        case .emailAndPassword(let email, let password):
            loginService.loginWithPassword(email: email, password: password, completion: completion)
        case .checkLogin:
            loginService.checkLoginAndFetchProfile(completion: completion)
        }
    }
    func register(registerType: RegisterType, completion: @escaping RegisterCompletion) {
        switch registerType {
        case .emailAndPassword(let email, let password):
            registerService.createAccountWithPassword(email: email, password: password, completion: completion)
        }
    }
    func logout(errorHandler: @escaping (Error?) -> Void) {
        do {
            try auth.signOut()
            errorHandler(nil)
        } catch {
            errorHandler(error)
        }
    }
}
