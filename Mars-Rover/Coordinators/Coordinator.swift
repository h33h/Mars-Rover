//
//  Coordinator.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

protocol Coordinator: AnyObject {
  func start()
  func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
  func coordinate(to coordinator: Coordinator) {
    coordinator.start()
  }
}
