//
//  AuthorizationTextField.swift
//  Mars Rover
//
//  Created by XXX on 2.11.21.
//

import UIKit

// IBDesignable for realtime view update in InterfaceBuilder
@IBDesignable
class AuthorizationTextField: UITextField {
  // MARK: - AuthorizationTextField: Variables
    // insetsWithMargin variable is used to change textfield insets depending of other views
    private var insetsWithMargin = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
    private var leftSideImageView = UIImageView()
    // if leftSideImageView not have image isleftSideImageisHidden will be false
    private var isleftSideImageisHidden = true {
      didSet {
        leftSideImageView.isHidden = isleftSideImageisHidden
      }
    }

  // MARK: - AuthorizationTextField: Inspectable Variables
    // IBInspectable for realtime update of values in InterfaceBuilder
    // leftSideImage for set image to leftSideImageView
    @IBInspectable var leftSideImage: UIImage? {
      didSet {
        guard leftSideImage != .none else {
          // if leftSideImage not have image left margin must be 6
          insetsWithMargin = UIEdgeInsets(top: 0, left: bounds.height + 6, bottom: 0, right: 6)
          isleftSideImageisHidden = true
          return
        }
        leftSideImageView.image = leftSideImage
        isleftSideImageisHidden = false
        // left: bounds.height + 8 (8 is half of leftSideImageView width) + 6 (6 is margin from leftSideImageView)
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

  // MARK: - AuthorizationTextField: Init methods
    // Required init methods
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      // call of setupView func than described in extension
      setupView()
    }

    override init(frame: CGRect) {
      super.init(frame: frame)
      // call of setupView func than described in extension
      setupView()
    }
}

extension AuthorizationTextField {
  // MARK: - AuthorizationTextField: Methods
    // called from init methods
    private func setupView() {
      // leftSideImageView setup
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
  // MARK: - AuthorizationTextField: Override Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      bounds.inset(by: insetsWithMargin)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      bounds.inset(by: insetsWithMargin)
    }
}
