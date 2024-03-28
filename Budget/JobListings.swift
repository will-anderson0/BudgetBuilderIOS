//
//  JobListings.swift
//  Budget
//
//  Created by Will Anderson on 3/23/24.
//

import Foundation
import SwiftUI

struct JobListings: View {
    var body: some View {
        ZStack {
            Color(UIColor(rgb: 0x8AAAE5)).ignoresSafeArea(.all)
            VStack {
                Text("Recommened Jobs")
                    .font(.title)
                
                Text("Job1")
                Text("Job2")
                Text("Job3")
                Text("Job4")
                Text("Job5")
                
            }
        }
        
    }
}

#Preview {
    JobListings()
}
