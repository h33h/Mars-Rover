//
//  GameViewController.swift
//  Mars Rover
//
//  Created by XXX on 30.10.21.
//

import UIKit

class MainMenuViewController: UIViewController, Storyboarded {
  // MARK: - MainMenuViewController: Variables
    private var viewModel = MainMenuViewModel()
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
      viewModel.signOutError.bind { [weak self] signOutError in
        if self?.navigationController?.viewControllers.last === self {
          self?.signOutError(error: signOutError)
        }
      }
      viewModel.profileFetched.bind { [weak self] profileFetched in
        if self?.navigationController?.viewControllers.last === self {
          self?.profileGet(profile: profileFetched)
        }
      }
      viewModel.fetchError.bind { [weak self] fetchError in
        if self?.navigationController?.viewControllers.last === self {
          self?.profileGetFailure(error: fetchError)
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

    func signOutError(error: String) {
      if !error.isEmpty {
        showSimpleNotificationAlert(title: "Sign Out Error", description: error)
      }
    }

    func profileGet(profile: ProfileModel) {
      DispatchQueue.main.async { [weak self] in
        self?.usernameLabel.text = profile.username
      }
    }

    func profileGetFailure(error: String) {
      if error == "Profile not exist" {
        viewModel.setupNewUser()
      } else if !error.isEmpty {
        showSimpleNotificationAlert(title: "Profile Get Error", description: error)
      }
    }
}
