//
//  DIContainer.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

import Swinject

class DIContainer {
  static let shared = DIContainer()
  let container = Container()
  lazy var assembler: Assembler = { Assembler(container: container) }()

  private init() {}

  func resolve<T>() -> T {
    guard let resolvedType = container.resolve(T.self) else { fatalError("Not found resolvedType") }
    return resolvedType
  }

  func resolve<T, Arg>(argument: Arg) -> T {
    guard let resolvedType = container.resolve(T.self, argument: argument) else { fatalError("Not found resolvedType") }
    return resolvedType
  }

  func resolve<T, Arg1, Arg2>(arguments arg1: Arg1, _ arg2: Arg2) -> T {
    guard let resolvedType = container.resolve(T.self, arguments: arg1, arg2) else {
      fatalError("Not found resolvedType")
    }
    return resolvedType
  }
}
