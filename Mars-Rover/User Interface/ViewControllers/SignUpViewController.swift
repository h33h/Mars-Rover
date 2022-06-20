//
//  SignUpViewController.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

class SignUpViewController: UIViewController {
  var viewModel: SignUpViewModel?

  @IBOutlet private var emailTextField: AuthorizationTextField!
  @IBOutlet private var passwordTextField: AuthorizationTextField!
  @IBOutlet private var reEnterPasswordTextField: AuthorizationTextField!
  @IBOutlet private var signUpButton: UIButton!
  @IBOutlet private var backButton: UIButton!
  @IBOutlet private var activityIndicator: UIActivityIndicatorView!

  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    emailTextField.delegate = self
    passwordTextField.delegate = self
    reEnterPasswordTextField.delegate = self
  }

  @IBAction private func signUpButtonAction(_ sender: Any) {
    guard
      let email = emailTextField.text,
      let password = passwordTextField.text,
      let reEnterPassword = reEnterPasswordTextField.text,
      !email.isEmpty, !password.isEmpty, !reEnterPassword.isEmpty
    else {
      showSimpleNotificationAlert(
        title: L10n.ViewControllers.SignUp.Error.title,
        description: L10n.ViewControllers.SignUp.Error.textFieldMessage
      )
      return
    }
    guard password == reEnterPassword else {
      showSimpleNotificationAlert(
        title: L10n.ViewControllers.SignUp.Error.title,
        description: L10n.ViewControllers.SignUp.Error.passwordMismatch
      )
      return
    }
    viewModel?.createAccount(signUpType: .emailAndPassword(email: email, password: password))
    setElementsDisabled(value: true)
  }

  @IBAction private func backButtonAction(_ sender: Any) {
    viewModel?.coordinator?.goBack()
  }

  private func bindViewModel() {
    viewModel?.signUpError.bind { [weak self] error in
      if let error = error {
        self?.showSimpleNotificationAlert(
          title: L10n.ViewControllers.SignUp.Error.title,
          description: error.localizedDescription
        )
      }
      self?.setElementsDisabled(value: false)
    }
  }

  private func setElementsDisabled(value: Bool) {
    emailTextField.isEnabled = !value
    passwordTextField.isEnabled = !value
    reEnterPasswordTextField.isEnabled = !value
    signUpButton.isEnabled = !value
    backButton.isEnabled = !value
    value ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
  }
}

extension SignUpViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
