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
  // MARK: - Application: Variables
    var window: UIWindow?
    var coordinator: AppCoordinator?
    // Set application oreintation to landscape mode
    var deviceOrientation = UIInterfaceOrientationMask.landscape

  // MARK: - Application Delegate
    func application(
      _ application: UIApplication,
      supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
      deviceOrientation
    }

  // MARK: - Application Life Cycle Methods
    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
      // Use Firebase library to configure APIs
      FirebaseApp.configure()
      window = UIWindow(frame: UIScreen.main.bounds)
      guard let window = window else { return false }
      coordinator = AppCoordinator(window: window)
      coordinator?.start()
      return true
    }
}
