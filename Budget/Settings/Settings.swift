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
        }
        
        // Link Plaid
        PlaidLinkViewControllerWrapper()
        
    }
}

struct PlaidLinkViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PlaidLinkViewController {
        return PlaidLinkViewController()
    }

    func updateUIViewController(_ uiViewController: PlaidLinkViewController, context: Context) {
        // Update the view controller if needed
    }
}
