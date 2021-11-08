//
//  Coordinator.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

protocol Coordinator: AnyObject {
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }

  func start()
}
