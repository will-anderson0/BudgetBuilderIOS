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
                SwipeBar(text: "Present", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                .font(.system(size: 22))
            
                
                SwipeBar(text: "Potenial", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
                .font(.system(size: 22))
            }
            .padding(.horizontal)
            
            TabView(selection: $selectedTab) {
                GreetingPage()
                    .tag(0)
                Page2View()
                    .tag(1)
            }
            
        }
        .tabViewStyle(PageTabViewStyle())
        .background(Color(UIColor(rgb: 0x8AAAE5)))
        
    }
}

struct SwipeBar: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(text)
                    .foregroundColor(isSelected ? Color(UIColor(rgb: 0xFCF6F5)) : .gray)
            }
        }
    }
}

struct Page2View: View {
    var body: some View {
        ZStack {
            Text("Graph of potential growth")
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

struct DetailView: View {
    var body: some View {
        VStack {
            Text("Detail Page")
                .font(.title)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Detail")
    }
}


#Preview {
    Home()
}
