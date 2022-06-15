//
//  SignUpFormViewController.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

class SignUpFormViewController: UIViewController {
  // MARK: - SignInFormViewController: Variables
    private var viewModel = SignUpFormViewModel(authService: FirebaseAuthService.shared)
    var coordinator: BackFlow?

  // MARK: - SignUpFormViewController: IBOutlet Variables
    @IBOutlet private var emailTextField: AuthorizationTextField!
    @IBOutlet private var passwordTextField: AuthorizationTextField!
    @IBOutlet private var reEnterPasswordTextField: AuthorizationTextField!
    @IBOutlet private var signUpButton: UIButton!
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

  // MARK: - SignUpFormViewController: Life Cycle Methods
    override func viewDidLoad() {
      super.viewDidLoad()
      emailTextField.delegate = self
      passwordTextField.delegate = self
      reEnterPasswordTextField.delegate = self
      viewModel.isSignedUp.bind { [weak self] isSignedUp in
        if self?.navigationController?.viewControllers.last === self {
          if isSignedUp {
            self?.successfullSignUp()
          }
        }
      }
      viewModel.signUpError.bind { [weak self] error in
        if self?.navigationController?.viewControllers.last === self {
          self?.failureSignUp(error: error)
        }
      }
    }

  // MARK: - SignInFormViewController: IBAction Methods
    @IBAction private func signUpButtonAction(_ sender: Any) {
      guard
        let email = emailTextField.text,
        let password = passwordTextField.text,
        let reEnterPassword = reEnterPasswordTextField.text,
        !email.isEmpty, !password.isEmpty, !reEnterPassword.isEmpty
      else {
        showSimpleNotificationAlert(
          title: "Sign Up Error",
          description: "Fill textfields in proper way"
        )
        return
      }
      guard password == reEnterPassword else {
        showSimpleNotificationAlert(
          title: "Sign Up Error",
          description: "Password Mismatch"
        )
        return
      }
      viewModel.createAccount(signUpType: .emailAndPassword(email: email, password: password))
      setElementsDisabled(value: true)
    }

    @IBAction private func backButtonAction(_ sender: Any) {
      coordinator?.goBack()
    }

    // MARK: - SignInFormViewController: Methods
    private func setElementsDisabled(value: Bool) {
      emailTextField.isEnabled = !value
      passwordTextField.isEnabled = !value
      reEnterPasswordTextField.isEnabled = !value
      signUpButton.isEnabled = !value
      backButton.isEnabled = !value
      value ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

extension SignUpFormViewController {
  // MARK: - SignUpFormViewController: Methods
    func failureSignUp(error: String) {
      if !error.isEmpty {
        showSimpleNotificationAlert(
          title: "Sign Up Error",
          description: error
        )
      }
      setElementsDisabled(value: false)
    }

    func successfullSignUp() {
      showSimpleNotificationAlert(
        title: "Successful Registration",
        description: "Check your email for the confirmation link"
      ) { [weak self] in
        self?.viewModel.isSignedUp.value = false
        self?.coordinator?.goBack()
      }
      setElementsDisabled(value: false)
    }
}

extension SignUpFormViewController: UITextFieldDelegate {
  // MARK: - SignUpFormViewController: UITextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }
}
