//
//  SwipeableCardStack.swift
//  Budget
//
//  Created by Will Anderson on 3/30/24.
//

import Foundation
import SwiftUI

struct SwipeableCardStack<Content: View>: View {
    @Binding var items: [Card]
    @Binding var currentIndex: Int
    @Binding var translation: CGSize
    let content: (Card) -> Content // Define content closure

    var body: some View {
        ZStack {
            ForEach(max(0, currentIndex - 1)...min(currentIndex + 1, items.count - 1), id: \.self) { index in
                let offset = CGFloat(index - currentIndex) * 20
                if index == currentIndex {
                    SwipeableCardView(content: {
                        content(items[index])
                    }, translation: translation)
                    .offset(x: offset, y: 0)
                    .rotationEffect(.degrees(Double(translation.width) / 20))
                    .scaleEffect(1 - abs(translation.width / 500))
                    .zIndex(1)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                translation = CGSize(width: value.translation.width, height: 0)
                            }
                            .onEnded { value in
                                withAnimation {
                                    if translation.width < -100 {
                                        currentIndex = min(currentIndex, items.count)
                                        let removedCard = items.remove(at: 0)
                                        items.append(removedCard)
                                    }
                                    translation = .zero
                                }
                            }
                    )
                } else {
                    SwipeableCardView(content: {
                        content(items[index])
                    }, translation: .zero)
                    .offset(x: offset, y: 0)
                    .rotationEffect(.degrees(0)) // No rotation for non-top cards
                    .scaleEffect(1)
                    .zIndex(Double(-abs(index - currentIndex)))
                }
            }
        }
        .padding()
    }
}
