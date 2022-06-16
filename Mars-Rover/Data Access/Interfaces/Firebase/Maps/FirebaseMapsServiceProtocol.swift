//
//  FirebaseMapsServiceProtocol.swift
//  Mars Rover
//
//  Created by XXX on 16.06.22.
//

typealias FirebaseMapModelCompletion = ([FirebaseMap]?, FirebaseMapsServiceError?) -> Void
typealias FirebaseMapActionCompletion = (FirebaseMapsServiceError?) -> Void

protocol FirebaseMapsServiceProtocol: FirebaseMapsActionServiceProtocol {
  func getMaps(completion: @escaping FirebaseMapModelCompletion)
}
