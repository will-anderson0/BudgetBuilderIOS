//
//  SwipeableCardView.swift
//  Budget
//
//  Created by Will Anderson on 3/30/24.
//

import Foundation
import SwiftUI

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
