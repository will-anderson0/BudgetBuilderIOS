//
//  GreetingPage.swift
//  Budget
//
//  Created by Will Anderson on 3/27/24.
//

import Foundation
import SwiftUI

struct GreetingPage: View {
    @State var firstName = ""
    @State var jobsCompleted = 0
    @State var accountBalance = 0
    @State var profitGoal = 0
    
    var body: some View {
        VStack {
            Spacer()
            Text("Good Morning, \(firstName)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            
            //Box to show Jobs Completed
            NumberBox(text: "Jobs Completed", money: false, number: jobsCompleted)
                .padding(.horizontal)
            
            //Box to show Profit Accumulated
            NumberBox(text: "Profit Accumulated", money: true, number: accountBalance)
                .padding(.horizontal)
            
            //Progress Bar to show progress toward profit goal
            ProgessBox(accountBalance: accountBalance, totalGoal: profitGoal)
                .padding(.horizontal)
            
            //Expand knowledge link
            //Swipe cards with fun facts and tips
            
            Spacer()
            
        }.task {
            await getUserData()
        }
    }
    
    func getUserData() async {
        do {
            let currentUser = try await supabase.auth.session.user
            
            let profile: Profile = try await supabase.database
                .from("profiles")
                .select("*")
                .eq("id", value: currentUser.id)
                .single()
                .execute()
                .value
            
            self.firstName = profile.firstName ?? ""
            self.jobsCompleted = profile.jobsCompleted ?? 0
            self.accountBalance = profile.accountBalance ?? 0
            self.profitGoal = profile.profitGoal ?? 0
            
        } catch {
            debugPrint(error)
        }
    }
}
