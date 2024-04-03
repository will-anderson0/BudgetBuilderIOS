//
//  BudgetSuggestions.swift
//  Budget
//
//  Created by Will Anderson on 3/23/24.
//

import Foundation
import SwiftUI

struct BudgetSuggestions: View {
    @State var totalTransactionValue = 0
    
    var body: some View {
        ZStack {
            Color(UIColor(rgb: 0x8AAAE5)).ignoresSafeArea(.all)
            VStack {
                Spacer()
                Text("Suggested Budget Method")
                    .foregroundColor(.white)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                Spacer()
                //Box to view all transactions in last 30 days
                NumberBox(text: "Total Monthly Transactions", money: true, number: totalTransactionValue)
                    .padding()
                
                //List of categories that have high spending
                
                Spacer()
            }
        }
    }
}

#Preview {
    BudgetSuggestions()
}
