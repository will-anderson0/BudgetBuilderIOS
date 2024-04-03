//
//  Settings.swift
//  Budget
//
//  Created by Will Anderson on 3/27/24.
//

import Foundation
import SwiftUI

struct Settings: View {
    @Binding var isAuthenticated: Bool
    let communicator: ServerCommunicator
    
    var body: some View {
        if isAuthenticated {
            Button("Sign out", role: .destructive) {
                Task {
                    do{
                        try await supabase.auth.signOut()
                        isAuthenticated = false
                    }
                }
            }
            // Link Plaid
            PlaidLinkView(communicator: communicator)
        }
    }
}
