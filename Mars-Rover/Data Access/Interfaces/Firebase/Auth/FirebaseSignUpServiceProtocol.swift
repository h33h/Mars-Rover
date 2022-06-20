//
//  FirebaseSignUpServiceProtocol.swift
//  Mars Rover
//
//  Created by XXX on 15.06.22.
//

enum SignUpType {
  case emailAndPassword(email: String, password: String)
}

typealias SignUpCompletion = (SignUpError?) -> Void

protocol FirebaseSignUpServiceProtocol {
  func signUp(with type: SignUpType, completion: @escaping SignUpCompletion)
}
