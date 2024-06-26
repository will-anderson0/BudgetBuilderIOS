//
//  Settings.swift
//  Budget
//
//  Created by Will Anderson on 3/23/24.
//

import Foundation
import SwiftUI
import Supabase

struct SettingsPage: View {
    @State var isAuthenticated = false
    let communicator = ServerCommunicator()
    
    
    var body: some View {
        ZStack {
            Color(UIColor(rgb: 0x8AAAE5)).ignoresSafeArea(.all)
            VStack {
                Login(isAuthenticated: $isAuthenticated)
                Settings(isAuthenticated: $isAuthenticated, communicator: communicator)

            }.onAppear() {
                authenticateUser()
            }

            
        }
    }
    
    
    func authenticateUser() {
        Task {
            do {
                for await state in await supabase.auth.authStateChanges {
                    print("Auth state: \(state.session != nil ? "Logged in" : "Logged out")")
                    
                    if [.initialSession, .signedIn, .signedOut].contains(state.event) {
                        DispatchQueue.main.async {
                            isAuthenticated = state.session != nil
                        }
                    }
                }
            }
        }
    }
    
    func signOut() {
        Task {
            do {
                try await supabase.auth.signOut()
                DispatchQueue.main.async {
                    isAuthenticated = false
                }
            }
        }
    }
}

#Preview {
    SettingsPage()
}
