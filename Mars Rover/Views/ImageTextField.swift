//
//  ImageTextField.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import UIKit

@IBDesignable
class ImageTextField: UITextField {
    private var insets = UIEdgeInsets()
    private var imageView = UIImageView()
    @IBInspectable var textFieldImage: UIImage = UIImage() {
        didSet {
            imageView.image = textFieldImage
            insets = UIEdgeInsets(top: 0, left: bounds.height + 6 + 12, bottom: 0, right: 12)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    private func setupView() {
        imageView.contentMode = .center
        imageView.frame = CGRect(x: -6, y: -6, width: bounds.height + 12, height: bounds.height + 12)
        imageView.tintColor = UIColor.black
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        backgroundColor = UIColor.white.withAlphaComponent(0.7)
        layer.cornerRadius = 10
        addSubview(imageView)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }
}
