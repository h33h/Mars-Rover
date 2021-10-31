//
//  AnimationController.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import Foundation
import UIKit

class FadeAnimationController: NSObject {
    enum AnimationType {
        case present
        case dismiss
    }
    var animationDuration: Double
    var animationType: AnimationType
    init(animationDuration: Double, animationType: AnimationType) {
        self.animationDuration = animationDuration
        self.animationType = animationType
    }
}

extension FadeAnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        TimeInterval(exactly: animationDuration) ?? 0
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else {
                  return transitionContext.completeTransition(false)
              }
        switch animationType {
        case .present:
            transitionContext.containerView.addSubview(toViewController.view)
            animation(with: transitionContext, viewToAnimate: toViewController.view, viewFromAnimate: fromViewController.view)
        case .dismiss:
            animation(with: transitionContext, viewToAnimate: toViewController.view, viewFromAnimate: fromViewController.view)
        }
    }
    func animation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView, viewFromAnimate: UIView) {
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration / 2,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            viewFromAnimate.alpha = 0
        },
                       completion: nil)
        UIView.animate(withDuration: duration / 2,
                       delay: duration / 2,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
            viewToAnimate.alpha = 1
        }, completion: {_ in
            transitionContext.completeTransition(true)
        })
    }
}
