//
//  LoginFormViewController.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import UIKit
import FirebaseAuth

class LoginFormViewController: UIViewController {
    private var presenter: LoginFormPresenter?
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var createAccountButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var resetPasswordButton: UIButton!
    @IBOutlet private var passwordTextField: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.login(loginType: .checkLogin)
        disableElements(value: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        presenter = LoginFormPresenter()
        presenter?.setDelegate(delegate: self)
        imageView.addParallax(offset: 40)
    }
    @IBAction private func passwordResetButtonAction(sender: UIButton) {
    }
    @IBAction private func loginButtonAction(sender: UIButton) {
        guard let email = usernameTextField.text, let password = passwordTextField.text else { return }
        presenter?.login(loginType: .emailAndPassword(email: email, password: password))
        disableElements(value: true)
    }
    @IBAction private func registerButtonAction(sender: UIButton) {
        guard let registerVC = storyboard?.instantiateViewController(withIdentifier: "registerVC") as? RegisterFormViewController else { return }
        registerVC.transitioningDelegate = registerVC
        present(registerVC, animated: true, completion: nil)
    }
    private func disableElements(value: Bool) {
        usernameTextField.isEnabled = !value
        passwordTextField.isEnabled = !value
        loginButton.isEnabled = !value
        createAccountButton.isEnabled = !value
        resetPasswordButton.isEnabled = !value
        value ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

extension LoginFormViewController: LoginFormPresenterDelegate {
    func successfullLogin(profile: ProfileModel) {
        guard let mainMenuVC = storyboard?.instantiateViewController(withIdentifier: "mainMenuVC") as? MainMenuViewController else { return }
        mainMenuVC.transitioningDelegate = mainMenuVC
        disableElements(value: false)
        present(mainMenuVC, animated: true, completion: nil)
    }
    func failureLogin(error: String) {
        guard !(error == "User is missed") else {
            disableElements(value: false)
            return
        }
        showSimpleNotificationAlert(title: "Login Error",
                                    description: error)
        disableElements(value: false)
    }
}

extension LoginFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
