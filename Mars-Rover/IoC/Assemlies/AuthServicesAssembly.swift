//
//  AuthServicesAssembly.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class AuthServicesAssembly: Assembly {
  func assemble(container: Container) {
    container.register(FirebaseSignInService.self) { _ in
      FirebaseSignInService()
    }
    .inObjectScope(.container)

    container.register(FirebaseSignUpService.self) { _ in
      FirebaseSignUpService()
    }
    .inObjectScope(.container)

    container.register(FirebaseAuthService.self) { resolver in
      let service = FirebaseAuthService()
      service.signInService = resolver.resolve(FirebaseSignInService.self)
      service.signUpService = resolver.resolve(FirebaseSignUpService.self)
      return service
    }
    .inObjectScope(.container)

    container.register(FirebaseProfileService.self) { _ in
      FirebaseProfileService()
    }
    .inObjectScope(.container)
  }
}
