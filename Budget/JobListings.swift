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
        VStack {
            Text("Recommened Jobs")
                .font(.title)
            
                List {
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
