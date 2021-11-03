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
    // Set application oreintation to landscape mode
    var deviceOrientation = UIInterfaceOrientationMask.landscape

    // MARK: - Application Delegate
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        deviceOrientation
    }

    // MARK: - Application Life Cycle Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        return true
    }

}
