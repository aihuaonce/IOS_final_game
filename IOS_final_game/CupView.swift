//
//  CupView.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/9.
//

import SwiftUI

struct CupView: View {
    let color: CupColor // 杯子的顏色
    let isTarget: Bool // 是否是目標排序的杯子 (用於樣式區分)
    var isSelected: Bool = false // 是否被玩家選中 (用於互動樣式)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10) // 杯子形狀
                .fill(color.swiftUIColor) // 填充顏色
                .frame(width: 45, height: 60) // 杯子大小
                .shadow(radius: isTarget ? 0 : 2) // 玩家的杯子有陰影
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.3), lineWidth: 1) // 杯子邊框
                )
            
            // 如果是目標排序的杯子，可以顯示數字或圖示
            if isTarget {
                Text("") // 這裡可以顯示杯子的數字或圖案 (你可以自己設計)
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .scaleEffect(isSelected ? 1.1 : 1.0) // 被選中時放大一點
        .animation(.spring(), value: isSelected) // 放大動畫
        .overlay( // 選中時添加外框
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.yellow : Color.clear, lineWidth: 3)
        )
    }
}
