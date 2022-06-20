//
//  AppDelegate.swift
//  Mars Rover
//
//  Created by XXX on 30.10.21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
  var coordinator: AppCoordinator?

  func application(
    _ application: UIApplication,
    supportedInterfaceOrientationsFor window: UIWindow?
  ) -> UIInterfaceOrientationMask {
    UIInterfaceOrientationMask.landscape
  }

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    guard let window = window else { return false }
    DIContainer.shared.assembler.apply(assembly: ApplicationAssembly())
    coordinator = DIContainer.shared.resolve(argument: window)
    coordinator?.start()
    return true
  }
}
