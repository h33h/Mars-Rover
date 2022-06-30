//
//  SignInViewController.swift
//  Mars Rover
//
//  Created by XXX on 2.11.21.
//

import UIKit

class SignInViewController: UIViewController, InteractionControllable {
  var viewModel: SignInViewModel?

  @IBOutlet private var emailTextField: AuthorizationTextField!
  @IBOutlet private var passwordTextField: AuthorizationTextField!
  @IBOutlet private var signInButton: UIButton!
  @IBOutlet private var createAccountButton: UIButton!
  @IBOutlet private var activityIndicator: UIActivityIndicatorView!

  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    setupDelegates()
  }

  @IBAction private func signInButtonAction(_ sender: Any) {
    guard
      let email = emailTextField.text,
      let password = passwordTextField.text,
      !email.isEmpty, !password.isEmpty
    else {
      showSimpleNotificationAlert(
        title: L10n.ViewControllers.SignIn.Error.title,
        description: L10n.ViewControllers.SignIn.Error.textFieldMessage
      )
      return
    }
    viewModel?.signIn(signInType: .emailAndPassword(email: email, password: password))
    interaction(is: .off)
  }

  @IBAction private func createAccountButtonAction(_ sender: Any) {
    viewModel?.coordinator?.coordinateToSignUp()
  }

  private func setupDelegates() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
  }

  private func bindViewModel() {
    viewModel?.signInError.bind { [weak self] error in
      self?.showSimpleNotificationAlert(
        title: L10n.ViewControllers.SignIn.Error.title,
        error: error
      )
      self?.interaction(is: .on)
    }
  }
}

extension SignInViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
