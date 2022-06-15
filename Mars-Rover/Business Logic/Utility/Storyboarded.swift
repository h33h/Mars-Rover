//
//  Storyboarded.swift
//  Mars Rover
//
//  Created by XXX on 8.11.21.
//

import UIKit

protocol Storyboarded: AnyObject {
  static func instantiate(from storyboardName: String) -> Self?
}

extension Storyboarded where Self: UIViewController {
  static func instantiate(from storyboardName: String) -> Self? {
    let id = String(describing: self)
    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: id) as? Self
  }
}
