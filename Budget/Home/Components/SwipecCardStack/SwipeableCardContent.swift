//
//  SwipeableCardContent.swift
//  Budget
//
//  Created by Will Anderson on 3/31/24.
//

import Foundation
import SwiftUI

struct SwipeableCardContent: View {
    let card: Card
    
    var body: some View {
        Text(card.text)
            .font(.system(size: 24))
            .padding()
    }
}
