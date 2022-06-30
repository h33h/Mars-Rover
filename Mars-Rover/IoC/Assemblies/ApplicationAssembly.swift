//
//  ApplicationAssembly.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class ApplicationAssembly: Assembly {
  func assemble(container: Container) {
    container.register(AppCoordinator.self) { _, window in
      AppCoordinator(window: window)
    }
  }
}
