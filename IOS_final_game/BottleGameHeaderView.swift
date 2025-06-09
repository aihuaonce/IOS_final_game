//
//  BottleGameHeaderView.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/9.
//

import SwiftUI

// 請確保 Triangle Shape 的定義也能被 GameHeaderView 存取到。
// 建議將 Triangle 放到單獨的檔案中。

struct GameHeaderView: View {
    @Binding var gameMessage: String // 用於顯示文字訊息
    // 新增：可選的正確序列，用於勝利後顯示杯子
    var correctSequenceToDisplay: [CupColor]?
    
    var body: some View {
        VStack(spacing: 0) { // 整個 GameHeaderView 的主要 VStack，間距設為 0 以便精確控制
            Spacer()

            // MARK: - 第一列：火柴人與對話框 (文字訊息)
            HStack(alignment: .bottom) {
                Image("matchstick_man")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.trailing, -20)

                // 顯示文字訊息的對話框
                Text(gameMessage)
                    .font(.title) // 字體更大
                    .multilineTextAlignment(.center) // 文字居中
                    .lineLimit(nil) // 允許無限行
                    .minimumScaleFactor(0.7) // 字體最小縮放比例，以防文字過長
                    .padding(25) // 增加內邊距來放大對話框
                    .frame(minWidth: 180, maxWidth: .infinity, minHeight: 100) // 設定最小寬高，並讓寬度填滿
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(radius: 3)
                    )
                    .overlay(
                        Triangle()
                            .fill(Color.white)
                            .frame(width: 25, height: 20) // 箭頭也稍微放大
                            .rotationEffect(.degrees(90))
                            .offset(x: -15, y: 0) // 微調箭頭位置
                        , alignment: .leading
                    )
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 20) // 火柴人對話框下方與下一列的間距

            // MARK: - 第二列：勝利時顯示正確順序的杯子
            if let sequence = correctSequenceToDisplay, !sequence.isEmpty {
                // 將杯子分兩列
                let totalCups = sequence.count
                let firstRowItemCount = (totalCups + 1) / 2 // 第一列的杯子數量

                let firstRowCups = Array(sequence.prefix(firstRowItemCount))
                let secondRowCups = Array(sequence.suffix(max(0, totalCups - firstRowItemCount)))

                VStack(spacing: 5) { // 兩列之間的垂直間距
                    // 第一列杯子
                    HStack(spacing: 5) { // 杯子之間的水平間距
                        ForEach(firstRowCups) { cupColor in
                            // 在 GameHeaderView 內顯示的杯子要比較小
                            CupView(color: cupColor, isTarget: true, customSize: CGSize(width: 40, height: 55))
                        }
                    }
                    .padding(.horizontal, 10) // 左右內邊距

                    // 第二列杯子 (如果有的話)
                    if !secondRowCups.isEmpty {
                        HStack(spacing: 5) { // 杯子之間的水平間距
                            ForEach(secondRowCups) { cupColor in
                                CupView(color: cupColor, isTarget: true, customSize: CGSize(width: 40, height: 55))
                            }
                        }
                        .padding(.horizontal, 10) // 左右內邊距
                    }
                }
                .padding(.vertical, 10) // 整個杯子區塊的上下內邊距
                .background(Color.yellow.opacity(0.2)) // 給杯子區塊一個淺色背景以作區隔
                .cornerRadius(10) // 圓角
                .shadow(radius: 2) // 陰影
                .padding(.horizontal) // 讓整個杯子區塊左右留白
                .transition(.opacity) // 淡入淡出動畫
                .animation(.easeInOut(duration: 0.5), value: sequence.count) // 當序列改變時觸發動畫
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow.opacity(0.2)) // 整個 Header 的背景色
    }
}
