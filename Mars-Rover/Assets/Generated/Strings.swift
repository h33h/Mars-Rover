// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Algorithm {
    internal enum FindPathError {
      /// The map is impassable
      internal static let impassable = L10n.tr("Localizable", "Algorithm.FindPathError.impassable")
    }
  }

  internal enum Entities {
    internal enum Obstacle {
      /// Hill
      internal static let hill = L10n.tr("Localizable", "Entities.Obstacle.hill")
      /// Hole
      internal static let pit = L10n.tr("Localizable", "Entities.Obstacle.pit")
      /// Sand
      internal static let sand = L10n.tr("Localizable", "Entities.Obstacle.sand")
      /// Solid Ground
      internal static let solidGround = L10n.tr("Localizable", "Entities.Obstacle.solidGround")
    }
    internal enum SCNBlockNode {
      internal enum Hill {
        /// art.scnassets/blockWithHill.scn
        internal static let path = L10n.tr("Localizable", "Entities.SCNBlockNode.hill.path")
      }
      internal enum Pit {
        /// art.scnassets/blockWithHole.scn
        internal static let path = L10n.tr("Localizable", "Entities.SCNBlockNode.pit.path")
      }
      internal enum Sand {
        /// art.scnassets/sandBlock.scn
        internal static let path = L10n.tr("Localizable", "Entities.SCNBlockNode.sand.path")
      }
      internal enum SolidGround {
        /// art.scnassets/solidBlock.scn
        internal static let path = L10n.tr("Localizable", "Entities.SCNBlockNode.solidGround.path")
      }
    }
  }

  internal enum Extensions {
    internal enum UIViewController {
      internal enum Notification {
        /// Ok
        internal static let ok = L10n.tr("Localizable", "Extensions.UIViewController.notification.ok")
      }
    }
  }

  internal enum Manager {
    internal enum RoverManager {
      /// art.scnassets/marsRover.scn
      internal static let path = L10n.tr("Localizable", "Manager.RoverManager.path")
    }
  }

  internal enum Network {
    internal enum Error {
      internal enum Firebase {
        internal enum Maps {
          /// Map list getting error
          internal static let fetchFirebaseError = L10n.tr("Localizable", "Network.Error.Firebase.Maps.fetchFirebaseError")
          /// Map does not exist
          internal static let mapNotExist = L10n.tr("Localizable", "Network.Error.Firebase.Maps.mapNotExist")
          /// User not signed in
          internal static let notSignedIn = L10n.tr("Localizable", "Network.Error.Firebase.Maps.notSignedIn")
        }
        internal enum Profile {
          /// User not signed in
          internal static let notSignedIn = L10n.tr("Localizable", "Network.Error.Firebase.Profile.notSignedIn")
          /// Profile does not exist
          internal static let profileNotExist = L10n.tr("Localizable", "Network.Error.Firebase.Profile.profileNotExist")
        }
        internal enum SignIn {
          /// Empty user data
          internal static let absentOfUser = L10n.tr("Localizable", "Network.Error.Firebase.SignIn.absentOfUser")
          /// User not signed in
          internal static let notSignedIn = L10n.tr("Localizable", "Network.Error.Firebase.SignIn.notSignedIn")
          /// Email is not verified
          internal static let notVerifiedEmail = L10n.tr("Localizable", "Network.Error.Firebase.SignIn.notVerifiedEmail")
        }
        internal enum SignUp {
          /// Empty user data
          internal static let absentOfUser = L10n.tr("Localizable", "Network.Error.Firebase.SignUp.absentOfUser")
        }
      }
    }
    internal enum FirebaseMap {
      /// colomns
      internal static let colomns = L10n.tr("Localizable", "Network.FirebaseMap.colomns")
      /// label
      internal static let label = L10n.tr("Localizable", "Network.FirebaseMap.label")
      /// lastEdited
      internal static let lastEdited = L10n.tr("Localizable", "Network.FirebaseMap.lastEdited")
      /// map
      internal static let map = L10n.tr("Localizable", "Network.FirebaseMap.map")
      /// mapContent
      internal static let mapContent = L10n.tr("Localizable", "Network.FirebaseMap.mapContent")
      /// maps
      internal static let maps = L10n.tr("Localizable", "Network.FirebaseMap.maps")
      /// rows
      internal static let rows = L10n.tr("Localizable", "Network.FirebaseMap.rows")
      /// size
      internal static let size = L10n.tr("Localizable", "Network.FirebaseMap.size")
      /// users
      internal static let users = L10n.tr("Localizable", "Network.FirebaseMap.users")
    }
    internal enum FirebaseProfile {
      /// username
      internal static let username = L10n.tr("Localizable", "Network.FirebaseProfile.username")
      /// users
      internal static let users = L10n.tr("Localizable", "Network.FirebaseProfile.users")
    }
    internal enum MapSync {
      /// sync
      internal static let sync = L10n.tr("Localizable", "Network.MapSync.sync")
    }
    internal enum RealmMap {
      /// id = %@
      internal static func filter(_ p1: Any) -> String {
        return L10n.tr("Localizable", "Network.RealmMap.filter", String(describing: p1))
      }
    }
  }

  internal enum ViewControllers {
    internal enum GameScreen {
      internal enum Error {
        /// Maps Failure
        internal static let title = L10n.tr("Localizable", "viewControllers.GameScreen.error.title")
      }
    }
    internal enum GameScreenScene {
      /// art.scnassets
      internal static let assetsPath = L10n.tr("Localizable", "viewControllers.GameScreenScene.assetsPath")
      /// board
      internal static let boardName = L10n.tr("Localizable", "viewControllers.GameScreenScene.boardName")
      /// mapScene.scn
      internal static let path = L10n.tr("Localizable", "viewControllers.GameScreenScene.path")
      /// rover
      internal static let roverName = L10n.tr("Localizable", "viewControllers.GameScreenScene.roverName")
    }
    internal enum MainMenu {
      internal enum Error {
        /// Profile Failure
        internal static let profileError = L10n.tr("Localizable", "viewControllers.MainMenu.error.profileError")
        /// Sign Out Failure
        internal static let signOutError = L10n.tr("Localizable", "viewControllers.MainMenu.error.signOutError")
      }
    }
    internal enum MapEditor {
      internal enum Error {
        /// Maps Failure
        internal static let title = L10n.tr("Localizable", "viewControllers.MapEditor.error.title")
      }
      internal enum Images {
        /// trash
        internal static let delete = L10n.tr("Localizable", "viewControllers.MapEditor.images.delete")
        /// pencil
        internal static let edit = L10n.tr("Localizable", "viewControllers.MapEditor.images.edit")
      }
    }
    internal enum MapEditorScene {
      /// art.scnassets
      internal static let assetsPath = L10n.tr("Localizable", "viewControllers.MapEditorScene.assetsPath")
      /// board
      internal static let boardName = L10n.tr("Localizable", "viewControllers.MapEditorScene.boardName")
      /// mapScene.scn
      internal static let path = L10n.tr("Localizable", "viewControllers.MapEditorScene.path")
    }
    internal enum MapTableViewCell {
      /// MapTableViewCell
      internal static let id = L10n.tr("Localizable", "viewControllers.MapTableViewCell.id")
    }
    internal enum SignIn {
      internal enum Error {
        /// Don't leave textfields empty
        internal static let textFieldMessage = L10n.tr("Localizable", "viewControllers.signIn.error.textFieldMessage")
        /// Sign In Failure
        internal static let title = L10n.tr("Localizable", "viewControllers.signIn.error.title")
      }
    }
    internal enum SignUp {
      internal enum Error {
        /// Password Mismatch
        internal static let passwordMismatch = L10n.tr("Localizable", "viewControllers.signUp.error.passwordMismatch")
        /// Fill textfields in proper way
        internal static let textFieldMessage = L10n.tr("Localizable", "viewControllers.signUp.error.textFieldMessage")
        /// Sign Up Failure
        internal static let title = L10n.tr("Localizable", "viewControllers.signUp.error.title")
      }
    }
  }

  internal enum ViewModels {
    internal enum MapEditor {
      internal enum SaveMap {
        /// Cancel
        internal static let cancel = L10n.tr("Localizable", "viewModels.mapEditor.saveMap.cancel")
        /// Save Map
        internal static let description = L10n.tr("Localizable", "viewModels.mapEditor.saveMap.description")
        /// Ok
        internal static let ok = L10n.tr("Localizable", "viewModels.mapEditor.saveMap.ok")
        /// Save Map
        internal static let title = L10n.tr("Localizable", "viewModels.mapEditor.saveMap.title")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
