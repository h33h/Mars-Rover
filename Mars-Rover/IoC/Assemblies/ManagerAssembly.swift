//
//  ManagerAssembly.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class ManagerAssembly: Assembly {
  func assemble(container: Container) {
    container.register(MapManager.self) { _, content in
      MapManager(mapContent: content)
    }

    container.register(RoverManager.self) { _, path in
      RoverManager(path: path)
    }
  }
}
