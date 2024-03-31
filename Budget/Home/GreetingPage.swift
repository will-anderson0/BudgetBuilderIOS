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
    @State var isExpandKnowledgePresented = false
    @State var cards = [
        Card(text: "Card 1"),
        Card(text: "Card 2"),
        Card(text: "Card 3"),
        Card(text: "Card 4"),
        Card(text: "Card 5"),
        Card(text: "Card 6"),
        Card(text: "Card 7")
        ]
    @State var currentIndex = 0
    @State var translation: CGSize = .zero

    
    var body: some View {
        VStack {
            Spacer()
            Text("Good Morning, \(firstName)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            
            //Box to show Jobs Completed
            /*NumberBox(text: "Jobs Completed", money: false, number: jobsCompleted)
                .padding(.horizontal)
            
            //Box to show Profit Accumulated
            NumberBox(text: "Profit Accumulated", money: true, number: accountBalance)
                .padding(.horizontal)
            
            //Progress Bar to show progress toward profit goal
            ProgessBox(accountBalance: accountBalance, totalGoal: profitGoal)
                .padding(.horizontal)
            
            //Expand knowledge link
            Button(action: {
                isExpandKnowledgePresented.toggle()
            }) {
                LinkBox(text: "Grow Your Knowledge")
                    .padding(.horizontal)
            }
            .sheet(isPresented: $isExpandKnowledgePresented) {
                ExpandKnowledge()
            }*/
            
            //Swipe cards with fun facts and tips
            SwipeableCardStack(items: $cards, currentIndex: $currentIndex, translation: $translation) { card in
                SwipeableCardContent(card: card)
            }


            
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

struct SwipeableCardContent: View {
    let card: Card

    var body: some View {
        Text(card.text)
            .font(.title)
            .padding()
    }
}
