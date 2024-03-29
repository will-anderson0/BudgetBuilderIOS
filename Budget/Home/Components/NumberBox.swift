//
//  NumberBox.swift
//  Budget
//
//  Created by Will Anderson on 3/28/24.
//

import Foundation
import SwiftUI

struct NumberBox: View {
    let text: String
    let number: Int
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 22))
                .foregroundColor(.gray)
                .padding(.leading, 10)
            
            Spacer()
            
            Text("\(number)")
                .font(.title)
                .foregroundColor(.white)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color(UIColor(rgb: 0x058ED9)))
                .cornerRadius(8)
        }
        .padding(10)
        .background(Color(UIColor(rgb: 0xFCF6F5)))
        .cornerRadius(12)
    }
}
