// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length implicit_return

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum Auth: StoryboardType {
    internal static let storyboardName = "Auth"

    internal static let signInViewController = SceneType<Mars_Rover.SignInViewController>(storyboard: Auth.self, identifier: "SignInViewController")

    internal static let signUpViewController = SceneType<Mars_Rover.SignUpViewController>(storyboard: Auth.self, identifier: "SignUpViewController")
  }
  internal enum GameScreens: StoryboardType {
    internal static let storyboardName = "GameScreens"

    internal static let gameScreenSceneViewController = SceneType<Mars_Rover.GameScreenSceneViewController>(storyboard: GameScreens.self, identifier: "GameScreenSceneViewController")

    internal static let mapEditorSceneViewController = SceneType<Mars_Rover.MapEditorSceneViewController>(storyboard: GameScreens.self, identifier: "MapEditorSceneViewController")
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum MainMenu: StoryboardType {
    internal static let storyboardName = "MainMenu"

    internal static let gameScreenViewController = SceneType<Mars_Rover.GameScreenViewController>(storyboard: MainMenu.self, identifier: "GameScreenViewController")

    internal static let mainMenuViewController = SceneType<Mars_Rover.MainMenuViewController>(storyboard: MainMenu.self, identifier: "MainMenuViewController")

    internal static let mapEditorViewController = SceneType<Mars_Rover.MapEditorViewController>(storyboard: MainMenu.self, identifier: "MapEditorViewController")
  }
  internal enum SplashScreen: StoryboardType {
    internal static let storyboardName = "SplashScreen"

    internal static let splashScreen = SceneType<UIKit.UIViewController>(storyboard: SplashScreen.self, identifier: "SplashScreen")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: BundleToken.bundle)
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    return storyboard.storyboard.instantiateViewController(identifier: identifier, creator: block)
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController(creator: block) else {
      fatalError("Storyboard \(storyboard.storyboardName) does not have an initial scene.")
    }
    return controller
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
