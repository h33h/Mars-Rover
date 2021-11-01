//
//  UIViewController.swift
//  Mars Rover
//
//  Created by XXX on 1.11.21.
//

import Foundation
import UIKit

extension UIViewController {
    func showSimpleNotificationAlert (title: String, description: String, buttonAction: (() -> Void)? = nil) {
        let errorAlert = UIAlertController()
        errorAlert.title = title
        errorAlert.message = description
        if let buttonAction = buttonAction {
            errorAlert.addAction(UIAlertAction(title: "Ok",
                                               style: .default,
                                               handler: { _ in
                                                            buttonAction()
                                                        }
                                              )
            )
        } else {
            errorAlert.addAction(UIAlertAction(title: "Ok",
                                               style: .default,
                                               handler: nil)
            )
        }
        present(errorAlert, animated: true, completion: nil)
    }
}
