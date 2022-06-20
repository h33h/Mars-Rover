//
//  FirebaseSignInServiceProtocol.swift
//  Mars Rover
//
//  Created by XXX on 15.06.22.
//

enum SignInType {
  case emailAndPassword(email: String, password: String)
}

typealias SignInCompletion = (SignInError?) -> Void

protocol FirebaseSignInServiceProtocol {
  func signIn(with type: SignInType, completion: @escaping SignInCompletion)
}
