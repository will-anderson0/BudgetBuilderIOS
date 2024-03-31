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
    let translation: CGSize // Add translation as a parameter

    var body: some View {
        let angle = -Double(translation.width) / 20 // Adjust the angle of rotation

        return RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .overlay(
                content()
                    .foregroundColor(.white)
            )
            .frame(width: 325, height: 150)
            .shadow(radius: 10)
            .rotationEffect(.degrees(angle))
            .offset(x: translation.width, y: 0) // Adjust the offset based on translation
            .opacity(translation.width == 0 ? 1 : 0.8) // Reduce opacity when swiping
    }
}
