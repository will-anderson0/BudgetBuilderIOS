//
//  GreetingPage.swift
//  Budget
//
//  Created by Will Anderson on 3/27/24.
//

import Foundation
import SwiftUI

struct GreetingPage: View {
    @State var username = "NOT SET"
    @State var jobsCompleted = 0
    
    var body: some View {
        ZStack {
            Text("Good Morning, \(username)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}
