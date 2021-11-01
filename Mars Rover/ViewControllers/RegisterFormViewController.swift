//
//  RegisterFormViewController.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import UIKit

class RegisterFormViewController: UIViewController {
    private var presenter: RegisterFormPresenter?
    @IBOutlet private var usernameTextField: ImageTextField!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var registerButton: UIButton!
    @IBOutlet private var passwordTextField: ImageTextField!
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var reEnterPasswordTextField: ImageTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        reEnterPasswordTextField.delegate = self
        presenter = RegisterFormPresenter()
        presenter?.setDelegate(delegate: self)
        imageView.addParallax(offset: 40)
    }
    @IBAction private func registerButtonAction(_ sender: UIButton) {
        guard let email = usernameTextField.text,
              let password = passwordTextField.text,
              let reEnterPassword = reEnterPasswordTextField.text else {
                  showSimpleNotificationAlert(title: "Registration Error",
                                              description: "Fill textfields in proper way")
                  return
              }
        guard password == reEnterPassword else {
            showSimpleNotificationAlert(title: "Registration Error",
                                        description: "Password Mismatch")
            return
        }
        presenter?.createAccount(registerType: .emailAndPassword(email: email,
                                                                 password: password))
        disableElements(value: true)
    }
    @IBAction private func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    private func disableElements(value: Bool) {
        usernameTextField.isEnabled = !value
        passwordTextField.isEnabled = !value
        reEnterPasswordTextField.isEnabled = !value
        registerButton.isEnabled = !value
        backButton.isEnabled = !value
        value ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

extension RegisterFormViewController: UIViewControllerTransitioningDelegate {
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

extension RegisterFormViewController: RegisterFormPresenterDelegate {
    func failureRegistration(error: String) {
        showSimpleNotificationAlert(title: "Registration Error",
                                    description: error)
        disableElements(value: false)
    }
    func successfullRegistration() {
        showSimpleNotificationAlert(title: "Successful Registration",
                                    description: "Check your email for the confirmation link") { [weak self] in
                self?.dismiss(animated: true)
        }
        disableElements(value: false)
    }
}

extension RegisterFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
