//
//  MainCoordinator.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit
import FirebaseAuth

protocol AppFlow: AnyObject {
  func coordinateToMainMenu()
  func coordinateToSignIn()
}

class AppCoordinator: BaseCoordinator, AppFlow {
  let window: UIWindow
  var stateListener: AuthStateDidChangeListenerHandle?

  init(window: UIWindow) {
    self.window = window
  }

  override func start() {
    navigationController.navigationBar.isHidden = true
    navigationController.pushViewController(StoryboardScene.SplashScreen.splashScreen.instantiate(), animated: true)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    stateListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
      self?.navigationController.popToRootViewController(animated: true)
      self?.removeChildCoordinators()
      if user != nil {
        self?.coordinateToMainMenu()
        return
      }
      self?.coordinateToSignIn()
    }
    DIContainer.shared.assembler.apply(assembly: AuthServicesAssembly())
  }

  func coordinateToSignIn() {
    DIContainer.shared.assembler.apply(assembly: SignInAssembly())
    let signInCoordinator: SignInCoordinator = DIContainer.shared.resolve()
    signInCoordinator.navigationController = navigationController
    coordinate(to: signInCoordinator)
  }

  func coordinateToMainMenu() {
    DIContainer.shared.assembler.apply(assembly: MenuAssembly())
    let mainMenuCoordinator: MainMenuCoordinator = DIContainer.shared.resolve()
    mainMenuCoordinator.navigationController = navigationController
    coordinate(to: mainMenuCoordinator)
  }
}
