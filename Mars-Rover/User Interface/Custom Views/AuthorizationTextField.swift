//
//  AuthorizationTextField.swift
//  Mars Rover
//
//  Created by XXX on 2.11.21.
//

import UIKit

@IBDesignable
class AuthorizationTextField: UITextField {
  private var insetsWithMargin = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
  private var leftSideImageView = UIImageView()
  private var isleftSideImageisHidden = true {
    didSet {
      leftSideImageView.isHidden = isleftSideImageisHidden
    }
  }

  @IBInspectable var leftSideImage: UIImage? {
    didSet {
      guard leftSideImage != .none else {
        insetsWithMargin = UIEdgeInsets(top: 0, left: bounds.height + 6, bottom: 0, right: 6)
        isleftSideImageisHidden = true
        return
      }
      leftSideImageView.image = leftSideImage
      isleftSideImageisHidden = false
      insetsWithMargin = UIEdgeInsets(top: 0, left: bounds.height + 8 + 6, bottom: 0, right: 6)
    }
  }

  @IBInspectable var leftSideImageTintColor: UIColor = .black {
    didSet {
      leftSideImageView.tintColor = leftSideImageTintColor
    }
  }

  @IBInspectable var leftSideImageBackgroundColor: UIColor = .white {
    didSet {
      leftSideImageView.backgroundColor = leftSideImageBackgroundColor
    }
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
}

extension AuthorizationTextField {
  private func setupView() {
    let margin: CGFloat = 16
    leftSideImageView.contentMode = .center
    leftSideImageView.frame = CGRect(
      x: -margin / 2,
      y: -margin / 2,
      width: bounds.height + margin,
      height: bounds.height + margin
    )
    leftSideImageView.layer.cornerRadius = leftSideImageView.bounds.width / 2
    leftSideImageView.isHidden = isleftSideImageisHidden
    addSubview(leftSideImageView)
  }
}

extension AuthorizationTextField {
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: insetsWithMargin)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: insetsWithMargin)
  }
}
