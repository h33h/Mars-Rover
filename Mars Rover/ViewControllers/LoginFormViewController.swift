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
        // subscribe emailTextField & passwordTextField delegates to self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // create presenter
        presenter = LoginFormPresenter()
        // subscribe presenter delegate to self
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
    // disable/enable all elements and start/stop activityIndicator
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
        // go to signUP VC
    }
}

extension LoginFormViewController: LoginFormPresenterDelegate {
    // MARK: - LoginFormViewController: LoginFormPresenterDelegate Methods
    // if login succeed
    func successfullLogin() {
        // storyboard that contains MainMenuViewController
        let mainMenuStoryboard = UIStoryboard(name: "MainMenu", bundle: nil)
        // instantinate MainMenuViewController from mainMenuStoryboard
        guard let mainMenuVC = mainMenuStoryboard.instantiateViewController(withIdentifier: "MainMenu") as? MainMenuViewController
        else { return }
        setElementsDisabled(value: false)
        // present mainMenuVC
        present(mainMenuVC, animated: true, completion: nil)
    }
    // if login failed
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
