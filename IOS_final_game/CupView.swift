//
//  CupView.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/9.
//

import SwiftUI

struct CupView: View {
    let color: CupColor
    let isTarget: Bool
    var isSelected: Bool = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color.swiftUIColor)
                .frame(width: 60, height: 80)
                .shadow(radius: isTarget ? 0 : 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                )
        }
        .scaleEffect(isSelected ? 1.1 : 1.0)
        .animation(.spring(), value: isSelected)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.yellow : Color.clear, lineWidth: 3)
        )
    }
}

