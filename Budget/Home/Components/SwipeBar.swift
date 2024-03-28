//
//  SwipeBar.swift
//  Budget
//
//  Created by Will Anderson on 3/27/24.
//

import Foundation
import SwiftUI

struct SwipeBar: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(text)
                    .foregroundColor(isSelected ? Color(UIColor(rgb: 0xFCF6F5)) : .gray)
            }
        }
    }
}
