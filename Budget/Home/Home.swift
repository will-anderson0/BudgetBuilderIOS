//
//  Home.swift
//  Budget
//
//  Created by Will Anderson on 3/23/24.
//

import Foundation
import SwiftUI

struct Home: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            HStack(spacing: 30) {
                SwipeBar(text: "Present", index: 0, selectedIndex: selectedTab) {
                    selectedTab = 0
                }
                .font(.system(size: 22))
                
                SwipeBar(text: "Potential", index: 1, selectedIndex: selectedTab) {
                    selectedTab = 1
                }
                .font(.system(size: 22))
            }
            .padding(.horizontal)
            
            TabView(selection: $selectedTab) {
                GreetingPage()
                    .tag(0)
                PotentialProfits()
                    .tag(1)
            }
            
        }
        .tabViewStyle(PageTabViewStyle())
        .background(Color(UIColor(rgb: 0x8AAAE5)))
        
    }
}

#Preview {
    Home()
}
