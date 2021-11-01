//
//  ProfileModel.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import Foundation

struct ProfileModel: Codable {
    var username: String?
    enum CodingKeys: String, CodingKey {
        case username
    }
}
