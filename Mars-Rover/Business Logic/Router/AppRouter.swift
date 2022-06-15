//
//  AppRouter.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

class AppRouter: Router {
  let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func push(_ viewController: UIViewController, isAnimated: Bool) {
    navigationController.pushViewController(viewController, animated: isAnimated)
    print(navigationController.viewControllers)
  }

  func pop(isAnimated: Bool) {
    navigationController.popViewController(animated: true)
  }
}
