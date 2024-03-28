//
//  ProfileView.swift
//  Budget
//
//  Created by Will Anderson on 3/27/24.
//

import Foundation

struct Profile: Decodable {
  let username: String?
  //let fullName: String?
  //let website: String?

  enum CodingKeys: String, CodingKey {
    case username
    //case fullName = "full_name"
    //case website
  }
}
