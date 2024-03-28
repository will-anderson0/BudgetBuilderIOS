//
//  ContentView.swift
//  Budget
//
//  Created by Will Anderson on 3/23/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(rgb: 0xFCF6F5)
    }
    
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            Home().tabItem {
                Label("Home", systemImage: "house")
            }
            JobListings().tabItem {
                Label("Listings", systemImage: "list.bullet.clipboard.fill")
            }
            BudgetSuggestions().tabItem {
                Label("Suggestions", systemImage: "dollarsign.circle.fill")
            }
            SettingsPage().tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
        .tint(.black)
        .environment(\.colorScheme, .light)
    }
}

#Preview {
    ContentView()
}
