//
//  Models.swift
//  Budget
//
//  Created by Will Anderson on 3/24/24.
//

import Foundation

struct Profile: Decodable {
  let username: String?
  let fullName: String?

  enum CodingKeys: String, CodingKey {
    case username
    case fullName = "full_name"
  }
}

struct UpdateProfileParams: Encodable {
  let username: String
  let fullName: String

  enum CodingKeys: String, CodingKey {
    case username
    case fullName = "full_name"
  }
}
