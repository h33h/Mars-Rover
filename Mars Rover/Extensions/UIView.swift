//
//  UIView.swift
//  Mars Rover
//
//  Created by XXX on 1.11.21.
//

import Foundation
import UIKit

extension UIView {
    func addParallax(offset: Int) {
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -offset
        horizontal.maximumRelativeValue = offset

        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -offset
        vertical.maximumRelativeValue = offset

        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        self.addMotionEffect(group)
    }
}
