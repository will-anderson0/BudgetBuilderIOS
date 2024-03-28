//
//  ProfileView.swift
//  Budget
//
//  Created by Will Anderson on 3/27/24.
//

import Foundation
import SwiftUI

struct Profile: Decodable {
    let username: String?
    let fullName: String?
    let jobsCompleted: Int?
    let totalAccumulatedValue: Int?
    
    enum CodingKeys: String, Int, CodingKeys {
        case username
        case fullName
        case jobsCompleted
        case totalAccumulatedValue
    }
}
