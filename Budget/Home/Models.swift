//
//  ProfileView.swift
//  Budget
//
//  Created by Will Anderson on 3/27/24.
//

import Foundation

struct Profile: Decodable {
    let username: String?
    let firstName: String?
    let lastName: String?
    let accountBalance: Int?
    let jobsCompleted: Int?
    let profitGoal: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case username
        case firstName = "first_name"
        case lastName  = "last_name"
        case accountBalance = "account_balance"
        case jobsCompleted = "jobs_completed"
        case profitGoal = "profit_goal"
    }
}
