//
//  GreetingPage.swift
//  Budget
//
//  Created by Will Anderson on 3/27/24.
//

import Foundation
import SwiftUI

struct GreetingPage: View {
    @State var username = ""
    @State var jobsCompleted = 0
    
    var body: some View {
        ZStack {
            Text("Good Morning, \(username)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
                .task {
                    await getUserData()
                    print(username)
                }
        }
    }
    
    func getUserData() async {
        do {
            let currentUser = try await supabase.auth.session.user
            
            let profile: Profile = try await supabase.database
                .from("profiles")
                .select()
                .eq("id", value: currentUser.id)
                .single()
                .execute()
                .value
            print(profile)
            
            self.username = profile.username ?? ""
            
        } catch {
            debugPrint(error)
        }
    }
}
