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
    let index: Int
    let selectedIndex: Int
    let action: () -> Void
    
    var isSelected: Bool {
        return index == selectedIndex
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(isSelected ? Color(UIColor(rgb: 0xFCF6F5)) : .gray)
                .fontWeight(.bold)
        }
        .disabled(true)
    }
}

