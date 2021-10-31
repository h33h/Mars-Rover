//
//  RegisterFormViewController.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import UIKit

class RegisterFormViewController: UIViewController {
    @IBOutlet private var usernameTextField: ImageTextField!
    @IBOutlet private var passwordTextField: ImageTextField!
    @IBOutlet private var reEnterPasswordTextField: ImageTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction private func registerButtonAction(_ sender: UIButton) {
    }
    @IBAction private func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension RegisterFormViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        FadeAnimationController(animationDuration: 2, animationType: .dismiss)
    }
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        FadeAnimationController(animationDuration: 2, animationType: .present)
    }
}
