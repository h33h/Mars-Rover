//
//  GameViewController.swift
//  Mars Rover
//
//  Created by XXX on 30.10.21.
//

import UIKit

class MainMenuViewController: UIViewController, Storyboarded {
  // MARK: - MainMenuViewController: Variables
  private var viewModel = MainMenuViewModel(
    authService: FirebaseAuthService.shared,
    profileService: FirebaseProfileService.shared,
    realmMapsService: RealmMapsServce.shared
  )
    var coordinator: MainMenuCoordinator?

  // MARK: - MainMenuViewController: IBOutlet Variables
    @IBOutlet private var usernameLabel: UILabel!

  // MARK: - MainMenuViewController: Life Cycle Methods
    override func viewDidLoad() {
      super.viewDidLoad()
      viewModel.getProfile()
      viewModel.isSignedOut.bind { [weak self] isSignedOut in
        if self?.navigationController?.viewControllers.last === self {
          if isSignedOut {
            self?.signOutAction()
          }
        }
      }
      viewModel.profile.bind { [weak self] profile in
        if self?.navigationController?.viewControllers.last === self {
          self?.profileGet(profile: profile)
        }
      }
      viewModel.errorMessage.bind { [weak self] errorMessage in
        if self?.navigationController?.viewControllers.last === self {
          self?.showError(error: errorMessage)
        }
      }
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      coordinator?.goBack()
    }

  // MARK: - MainMenuViewController: IBAction Methods
    @IBAction private func signOutButton(_ sender: Any) {
      viewModel.signOut()
    }
  @IBAction func mapsButton(_ sender: Any) {
    coordinator?.goToMaps()
  }
  @IBAction func playButton(_ sender: Any) {
  }
}

extension MainMenuViewController {
  // MARK: - MainMenuViewController: Methods
    func signOutAction() {
      viewModel.isSignedOut.value = false
      coordinator?.goBack()
      self.navigationController?.popViewController(animated: true)
    }

    func profileGet(profile: ProfileModel) {
      DispatchQueue.main.async { [weak self] in
        self?.usernameLabel.text = profile.username
      }
    }

    func showError(error: String) {
      if error == "Profile not exist" {
        viewModel.setupNewUser()
      } else if !error.isEmpty {
        showSimpleNotificationAlert(title: "Error", description: error)
      }
    }
}
