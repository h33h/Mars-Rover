//
//  UIViewController+Extensions.swift
//  Mars Rover
//
//  Created by XXX on 3.11.21.
//

import UIKit

extension UIViewController {
  func showSimpleNotificationAlert(
    title: String,
    description: String,
    buttonAction: (() -> Void)? = nil
  ) {
    let errorAlert = UIAlertController()
    errorAlert.title = title
    errorAlert.message = description
    if let buttonAction = buttonAction {
      errorAlert.addAction(
        UIAlertAction(
          title: L10n.Extensions.UIViewController.Notification.ok,
          style: .default
        ) { _ in
          buttonAction()
        }
      )
    } else {
      errorAlert.addAction(
        UIAlertAction(
          title: L10n.Extensions.UIViewController.Notification.ok,
          style: .default,
          handler: nil
        )
      )
    }
    present(errorAlert, animated: true, completion: nil)
  }
}
