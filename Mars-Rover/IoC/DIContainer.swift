//
//  DIContainer.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class DIContainer {
  static let shared = DIContainer()
  lazy var container = Container()
  lazy var assembler = Assembler(container: container)

  private init() {}

  func resolve<T>() -> T {
    guard
      let resolvedObject = container.resolve(T.self)
    else { fatalError(L10n.IoC.DIContainer.Error.description) }

    return resolvedObject
  }

  func resolve<T, Arg>(argument: Arg) -> T {
    guard
      let resolvedObject = container.resolve(T.self, argument: argument)
    else { fatalError(L10n.IoC.DIContainer.Error.description) }

    return resolvedObject
  }

  func resolve<T, Arg1, Arg2>(arguments arg1: Arg1, _ arg2: Arg2) -> T {
    guard
      let resolvedObject = container.resolve(T.self, arguments: arg1, arg2)
    else { fatalError(L10n.IoC.DIContainer.Error.description) }

    return resolvedObject
  }
}
