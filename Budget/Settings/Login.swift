//
//  Login.swift
//  Budget
//
//  Created by Will Anderson on 3/24/24.
//

import Foundation
import SwiftUI
import Supabase

struct Login: View {
    @Binding var isAuthenticated: Bool
    @State var email = ""
    @State var password = ""
    @State var isLoading = false
    @State var resultSignIn: Result<Void, Error>?
    @State var resultCreateAccount: Result<Void, Error>?
    
    var body: some View {
        if !isAuthenticated {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(.emailAddress)
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(.password)
                
                
                HStack {
                    Button("Sign in") {
                        signInButtonTapped()
                    }
                    Button("Create Account") {
                        //createAccountButtonTapped()
                    }
                }
                if let resultSignIn {
                    Section {
                        switch resultSignIn {
                        case .success:
                            Text("Login successful")
                        case .failure(let error):
                            Text(error.localizedDescription).foregroundStyle(.red)
                        }
                    }
                }
                if let resultCreateAccount {
                    Section {
                        switch resultCreateAccount {
                        case .success:
                            Text("Check your inbox.")
                        case .failure(let error):
                            Text(error.localizedDescription).foregroundStyle(.red)
                        }
                    }
                }
                if isLoading {
                    ProgressView()
                }
            }
            .padding()
        }
    }
    
    func signInButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                try await supabase.auth.signIn(email: email, password: password)
                resultSignIn = .success(())
                isAuthenticated = true
            } catch {
                resultSignIn = .failure(error)
                print("Error signing in:", error)
            }
            
        }
    }
    
    func createAccountButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                try await supabase.auth.signInWithOTP(
                    email: email,
                    redirectTo: URL(string: "io.supabase.user-management://login-callback")
                )
                resultCreateAccount = .success(())
            } catch {
                resultCreateAccount = .failure(error)
            }
        }
    }
    
}

#Preview {
    Login(isAuthenticated: .constant(false))
}
