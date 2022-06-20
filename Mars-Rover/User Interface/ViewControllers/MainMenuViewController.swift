//
//  GameViewController.swift
//  Mars Rover
//
//  Created by XXX on 30.10.21.
//

import UIKit

class MainMenuViewController: UIViewController {
  var viewModel: MainMenuViewModel?

  @IBOutlet private var usernameLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel?.getProfile()
    bindViewModel()
  }

  @IBAction private func signOutButton(_ sender: Any) {
    viewModel?.signOut()
  }

  @IBAction private func mapsButton(_ sender: Any) {
    viewModel?.coordinator?.coordinateToMapEditor()
  }

  @IBAction private func playButton(_ sender: Any) {
    viewModel?.coordinator?.coordinateToGameScreen()
  }

  private func bindViewModel() {
    viewModel?.profileResponse.bind { [weak self] profile, error in
      if let error = error {
        self?.showSimpleNotificationAlert(
          title: L10n.ViewControllers.MainMenu.Error.profileError,
          description: error.localizedDescription)
      }
      if let profile = profile {
        self?.usernameLabel.text = profile.username
      }
    }

    viewModel?.signOutError.bind { [weak self] error in
      if let error = error {
        self?.showSimpleNotificationAlert(
          title: L10n.ViewControllers.MainMenu.Error.signOutError,
          description: error.localizedDescription)
      }
    }
  }
}
