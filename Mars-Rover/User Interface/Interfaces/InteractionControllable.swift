//
//  InteractionControllable.swift
//  Mars Rover
//
//  Created by Yauheni Fiadotau on 30.06.22.
//

import UIKit

enum InteractionState {
  case on
  case off
}

protocol InteractionControllable: UIViewController {
  func interaction(is state: InteractionState)
}

extension InteractionControllable {
  func interaction(is state: InteractionState) {
    switch state {
    case .on:
      for view in view.subviews {
        if let controlView = view as? UIControl {
          controlView.isEnabled = true
        }
        if let indicatorView = view as? UIActivityIndicatorView {
          indicatorView.stopAnimating()
        }
      }
    case .off:
      for view in view.subviews {
        if let controlView = view as? UIControl {
          controlView.isEnabled = false
        }
        if let indicatorView = view as? UIActivityIndicatorView {
          indicatorView.startAnimating()
        }
      }
    }
  }
}
