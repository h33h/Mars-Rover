//
//  FirebaseAuthServiceProtocol.swift
//  Mars Rover
//
//  Created by XXX on 15.06.22.
//

protocol FirebaseAuthServiceProtocol: FirebaseSignInServiceProtocol, FirebaseSignUpServiceProtocol {
  func signOut(errorHandler: @escaping (Error?) -> Void)
}
