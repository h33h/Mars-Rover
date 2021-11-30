//
//  Router.swift
//  Mars Rover
//
//  Created by XXX on 27.11.21.
//

import UIKit

protocol Router: AnyObject {
  func push(_ viewController: UIViewController, isAnimated: Bool)
  func pop(isAnimated: Bool)
}
