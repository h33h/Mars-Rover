//
//  SignInFormViewController.swift
//  Mars Rover
//
//  Created by XXX on 2.11.21.
//

import UIKit

class SignInFormViewController: UIViewController {
  // MARK: - SignInFormViewController: Variables
    private var presenter: SignInFormPresenter?

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
      presenter = SignInFormPresenter()
      presenter?.setDelegate(delegate: self)
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      // when view appear check for login status
      presenter?.signIn(signInType: .checkSignIn)
      setElementsDisabled(value: true)
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
      presenter?.signIn(signInType: .emailAndPassword(email: email, password: password))
      setElementsDisabled(value: true)
    }

    @IBAction private func createAccountButtonAction(_ sender: Any) {
      // TODO: go to signUP VC
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

extension SignInFormViewController: SignInFormPresenterDelegate {
  // MARK: - SignInFormViewController: SignInFormPresenterDelegate Methods
    func successfullSignIn() {
      // storyboard that contains MainMenuViewController
        let mainMenuStoryboard = UIStoryboard(name: "MainMenu", bundle: nil)
        guard let mainMenuVC = mainMenuStoryboard.instantiateViewController(withIdentifier: "MainMenu")
          as? MainMenuViewController
        else { return }
        setElementsDisabled(value: false)
        present(mainMenuVC, animated: true, completion: nil)
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
