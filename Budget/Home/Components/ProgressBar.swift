//
//  ProgressBar.swift
//  Budget
//
//  Created by Will Anderson on 3/28/24.
//

import Foundation
import SwiftUI

struct ProgessBox: View {
    let accountBalance: Int
    let totalGoal: Int
    let percent: Double
    
    init(accountBalance: Int, totalGoal: Int) {
        self.accountBalance = accountBalance
        self.totalGoal = totalGoal
        self.percent = Double(accountBalance) / Double(totalGoal)
    }
    
    var body: some View {
        VStack{
            HStack {
                Text("Goal: \(String(format: "%.0f", percent * 100))% complete")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                
                Spacer()
                
                Text("$\(totalGoal)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(Color(UIColor(rgb: 0x058ED9)))
                    .cornerRadius(8)
            }
            ProgressView(value: percent, total: 1.0)
                .padding(.horizontal)
                .tint(Color(UIColor(rgb: 0x058ED9)))
            
            
        }
        .padding(10)
        .background(Color(UIColor(rgb: 0xFCF6F5)))
        .cornerRadius(12)
        
    }
}
