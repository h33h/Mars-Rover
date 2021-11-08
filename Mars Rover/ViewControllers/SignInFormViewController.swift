//
//  SignInFormViewController.swift
//  Mars Rover
//
//  Created by XXX on 2.11.21.
//

import UIKit

class SignInFormViewController: UIViewController, Storyboarded {
  // MARK: - SignInFormViewController: Variables
    private var viewModel = SignInFormViewModel()
    weak var coordinator: MainCoordinator?

  // MARK: - SignInFormViewController: IBOutlet Variables
    @IBOutlet private var emailTextField: AuthorizationTextField!
    @IBOutlet private var passwordTextField: AuthorizationTextField!
    @IBOutlet private var signInButton: UIButton!
    @IBOutlet private var createAccountButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

  // MARK: - SignInFormViewController: Life Cycle Methods
    override func viewDidLoad() {
      super.viewDidLoad()
      emailTextField.delegate = self
      passwordTextField.delegate = self
      viewModel.signIn(signInType: .checkSignIn)
      setElementsDisabled(value: true)
      viewModel.isSignedIn.bind { [weak self] isSigned in
        if self?.navigationController?.viewControllers.last === self {
          if isSigned {
            self?.successfullSignIn()
          }
        }
      }
      viewModel.signInError.bind { [weak self] error in
        if self?.navigationController?.viewControllers.last === self {
          self?.failureSignIn(error: error)
        }
      }
    }

  // MARK: - SignInFormViewController: IBAction Methods
    @IBAction private func signInButtonAction(_ sender: Any) {
      guard
        let email = emailTextField.text,
        let password = passwordTextField.text,
        !email.isEmpty, !password.isEmpty
      else {
        showSimpleNotificationAlert(
          title: "Sign In Failure",
          description: "Don't leave textfields empty"
        )
        return
      }
      viewModel.signIn(signInType: .emailAndPassword(email: email, password: password))
      setElementsDisabled(value: true)
    }

    @IBAction private func createAccountButtonAction(_ sender: Any) {
      coordinator?.goToSignUpForm()
    }

    // MARK: - SignInFormViewController: Methods
      private func setElementsDisabled(value: Bool) {
        emailTextField.isEnabled = !value
        passwordTextField.isEnabled = !value
        signInButton.isEnabled = !value
        createAccountButton.isEnabled = !value
        value ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
      }
}

extension SignInFormViewController {
  // MARK: - SignInFormViewController: Methods
    func successfullSignIn() {
      coordinator?.goToMainMenu()
      setElementsDisabled(value: false)
    }

    func failureSignIn(error: String) {
      if !error.isEmpty {
        showSimpleNotificationAlert(title: "Sign In Failure", description: error)
      }
      setElementsDisabled(value: false)
    }
}

extension SignInFormViewController: UITextFieldDelegate {
  // MARK: - SignInFormViewController: UITextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      // when click on return button, keyboard closes
      textField.resignFirstResponder()
      return true
    }
}
