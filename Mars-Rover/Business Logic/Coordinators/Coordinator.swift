//
//  Coordinator.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

protocol Coordinator: AnyObject {
  var navigationController: UINavigationController { get set }
  var parentCoordinator: Coordinator? { get set }

  func start()
  func coordinate(to coordinator: Coordinator)
  func didFinish(coordinator: Coordinator)
  func removeChildCoordinators()
}
