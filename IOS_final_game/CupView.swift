//
//  CupView.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/9.
//

import SwiftUI

extension CupColor {
    var localizedName: String {
        switch self {
        case .red: return "紅色"
        case .blue: return "藍色"
        case .green: return "綠色"
        case .yellow: return "黃色"
        case .orange: return "橘色"
        case .purple: return "紫色"
        case .cyan: return "青色"
        case .magenta: return "洋紅色"
        case .brown: return "棕色"
        case .white: return "白色"
        }
    }
}

struct CupView: View {
    let color: CupColor
    let isTarget: Bool
    var isSelected: Bool = false
    var customSize: CGSize?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color.swiftUIColor)
                .frame(width: customSize?.width ?? 60, height: customSize?.height ?? 80)
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

