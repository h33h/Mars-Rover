//
//  LoginFormViewController.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import UIKit

class LoginFormViewController: UIViewController {
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction private func passwordResetButtonAction(sender: UIButton) {
    }
    @IBAction private func loginButtonAction(sender: UIButton) {
    }
    @IBAction private func registerButtonAction(sender: UIButton) {
        guard let registerVC = storyboard?.instantiateViewController(withIdentifier: "registerVC") as? RegisterFormViewController else { return }
        registerVC.transitioningDelegate = registerVC
        present(registerVC, animated: true, completion: nil)
    }
}
