//
//  LoginFormViewController.swift
//  Mars Rover
//
//  Created by XXX on 2.11.21.
//

import UIKit

class LoginFormViewController: UIViewController {

    // MARK: - LoginFormViewController: Variables
    private var presenter: LoginFormPresenter?

    // MARK: - LoginFormViewController: IBOutlet Variables
    @IBOutlet private var emailTextField: AuthorizationTextField!
    @IBOutlet private var passwordTextField: AuthorizationTextField!
    @IBOutlet private var signInButton: UIButton!
    @IBOutlet private var createAccountButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    // MARK: - LoginFormViewController: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        presenter = LoginFormPresenter()
        presenter?.setDelegate(delegate: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // when view appear check for login status
        presenter?.login()
        setElementsDisabled(value: true)
    }

}

extension LoginFormViewController {

    // MARK: - LoginFormViewController: Methods
    private func setElementsDisabled(value: Bool) {
        emailTextField.isEnabled = !value
        passwordTextField.isEnabled = !value
        signInButton.isEnabled = !value
        createAccountButton.isEnabled = !value
        value ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }

}

extension LoginFormViewController {

    // MARK: - LoginFormViewController: IBAction Methods
    @IBAction private func signInButtonAction(_ sender: Any) {
        presenter?.login()
    }

    @IBAction private func createAccountButtonAction(_ sender: Any) {
        // TODO: go to signUP VC
    }

}

extension LoginFormViewController: LoginFormPresenterDelegate {

    // MARK: - LoginFormViewController: LoginFormPresenterDelegate Methods
    func successfullLogin() {
        // storyboard that contains MainMenuViewController
        let mainMenuStoryboard = UIStoryboard(name: "MainMenu", bundle: nil)
        guard let mainMenuVC = mainMenuStoryboard.instantiateViewController(withIdentifier: "MainMenu") as? MainMenuViewController
        else { return }
        setElementsDisabled(value: false)
        present(mainMenuVC, animated: true, completion: nil)
    }

    func failureLogin(error: String) {
        setElementsDisabled(value: false)
    }

}

extension LoginFormViewController: UITextFieldDelegate {

    // MARK: - LoginFormViewController: UITextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // when click on return button, keyboard closes
        textField.resignFirstResponder()
        return true
    }

}
