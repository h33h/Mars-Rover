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
    buttonAction: @escaping ((UIAlertAction) -> Void) = { _ in }
  ) {
    let errorAlert = UIAlertController()
    errorAlert.title = title
    errorAlert.message = description
    errorAlert.addAction(
      UIAlertAction(
        title: L10n.Extensions.UIViewController.Notification.ok,
        style: .default,
        handler: buttonAction
      )
    )
    present(errorAlert, animated: true, completion: nil)
  }

  func showSimpleNotificationAlert(
    title: String,
    error: Error?,
    buttonAction: @escaping ((UIAlertAction) -> Void) = { _ in }
  ) {
    let errorAlert = UIAlertController()
    errorAlert.title = title
    errorAlert.message = error?.localizedDescription
    errorAlert.addAction(
      UIAlertAction(
        title: L10n.Extensions.UIViewController.Notification.ok,
        style: .default,
        handler: buttonAction
      )
    )
    present(errorAlert, animated: true, completion: nil)
  }
}
