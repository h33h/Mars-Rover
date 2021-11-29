//
//  MainCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

class AppCoordinator: Coordinator {
  let window: UIWindow
  let rootNavigationVC: UINavigationController

  init(window: UIWindow) {
    self.window = window
    self.rootNavigationVC = UINavigationController()
  }

  func start() {
    rootNavigationVC.navigationBar.isHidden = true
    window.rootViewController = rootNavigationVC
    window.makeKeyAndVisible()
    let router = AppRouter(navigationController: rootNavigationVC)
    let signInCoordinator = SignInCoordinator(router: router)
    coordinate(to: signInCoordinator)
  }
}
