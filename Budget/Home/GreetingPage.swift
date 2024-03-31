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
            let cards = [
                    Card(text: "Card 1"),
                    Card(text: "Card 2"),
                    Card(text: "Card 3"),
                    Card(text: "Card 4")
                ]
            SwipeableCardStack(items: cards) { card in
                        Text(card.text)
                            .font(.title)
                            .padding()
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

struct SwipeableCardStack<T: Identifiable, Content: View>: View {
    let items: [T]
    let content: (T) -> Content
    
    @State var displayedItems: [T]
    @State var translation: CGSize = .zero
    @State var currentIndex = 0
    
    init(items: [T], content: @escaping (T) -> Content) {
        self.items = items
        self.content = content
        self._displayedItems = State(initialValue: items)
    }
    
    var body: some View {
        ZStack {
            ForEach(displayedItems, id: \.id) { item in
                SwipeableCardView(content: {
                    content(item)
                })
                .offset(x: 0, y: self.currentIndex == self.displayedItems.count - 1 ? self.translation.height : 0)
                .offset(x: self.translation.width, y: 0)
                .rotationEffect(.degrees(self.currentIndex == self.displayedItems.count - 1 ? Double(self.translation.width) / 20 : 0))
                .scaleEffect(self.currentIndex == self.displayedItems.count - 1 ? 1 - abs(self.translation.width / 500) : 1)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.translation = value.translation
                        }
                        .onEnded { value in
                            withAnimation {
                                if self.translation.width > 100 {
                                    self.currentIndex = (self.currentIndex + 1) % self.displayedItems.count
                                    if abs(self.translation.width) > 125 { // Adjust this threshold as needed
                                        self.displayedItems.remove(at: self.displayedItems.count - 1)
                                    }
                                } else if self.translation.width < -100 {
                                    self.currentIndex = (self.currentIndex - 1 + self.displayedItems.count) % self.displayedItems.count
                                    if abs(self.translation.width) > 125 { // Adjust this threshold as needed
                                        self.displayedItems.remove(at: self.displayedItems.count - 1)
                                    }
                                }
                                self.translation = .zero
                            }
                        }
                )
            }
        }
        .padding()
    }
}



struct SwipeableCardView<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .overlay(
                content()
                    .foregroundColor(.white)
            )
            .frame(width: 300, height: 400)
            .shadow(radius: 10)
    }
}

struct Card: Identifiable {
    let id = UUID()
    let text: String
}
