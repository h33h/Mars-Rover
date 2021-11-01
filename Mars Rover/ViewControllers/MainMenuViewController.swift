//
//  GameViewController.swift
//  Mars Rover
//
//  Created by XXX on 30.10.21.
//

import UIKit

class MainMenuViewController: UIViewController {
    private var presenter: MainMenuPresenter?
    @IBOutlet private var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainMenuPresenter()
        presenter?.setDelegate(delegate: self)
        presenter?.getProfile()
    }
    @IBAction private func logOutAction(_ sender: Any) {
        presenter?.logout()
    }
}

extension MainMenuViewController: MainMenuPresenterDelegate {
    func logoutAction() {
        dismiss(animated: true, completion: nil)
    }
    func logoutError(error: String) {
        showSimpleNotificationAlert(title: "Sign out error",
                                    description: error)
    }
    func profileGet(profile: ProfileModel) {
        DispatchQueue.main.async { [weak self] in
            self?.userNameLabel.text = "Logged as: \(String(describing: profile.username))"
        }
    }
    func profileGetFailure(error: String) {
        showSimpleNotificationAlert(title: "Profile Error",
                                    description: error)
    }
}

extension MainMenuViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        FadeAnimationController(animationDuration: 2,
                                animationType: .dismiss)
    }
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        FadeAnimationController(animationDuration: 2,
                                animationType: .present)
    }
}
