//
//  FirebaseAuthServiceProtocol.swift
//  Mars Rover
//
//  Created by XXX on 15.06.22.
//

typealias SignOutCompletion = (Error?) -> Void

protocol FirebaseAuthServiceProtocol: FirebaseSignInServiceProtocol, FirebaseSignUpServiceProtocol {
  func signOut(completion: @escaping SignOutCompletion)
}
