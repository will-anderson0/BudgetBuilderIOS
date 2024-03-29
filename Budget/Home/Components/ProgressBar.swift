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
    
    var body: some View {
        VStack{
            HStack {
                Text("Goal Progress")
                    .font(.system(size: 22))
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
            ProgressView(value: Double(accountBalance) / Double(totalGoal), total: 1.0)
                .padding(.horizontal)
                .tint(Color(UIColor(rgb: 0x058ED9)))

            
        }
        .padding(10)
        .background(Color(UIColor(rgb: 0xFCF6F5)))
        .cornerRadius(12)
        
    }
}
