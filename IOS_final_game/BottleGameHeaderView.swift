//
//  BottleGameHeaderView.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/9.
//

import SwiftUI

// 請確保 Triangle Shape 的定義也能被 GameHeaderView 存取到
// 如果 Triangle 也是在 BottleGameView.swift 中定義的，你可能需要將它移到單獨的檔案，或者確保它在 GameHeaderView 之前被定義。
// 建議將 Triangle 也放到單獨的檔案中。

struct GameHeaderView: View {
    @Binding var gameMessage: String // 使用 @Binding 來接收外部傳入的訊息

    var body: some View {
        VStack {
            Spacer() // 將內容往中間推

            HStack(alignment: .bottom) { // 將火柴人與對話框的底部對齊
                Image("matchstick_man") // 你的火柴人圖片
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150) // 火柴人圖片大小
                    .padding(.trailing, -20) // 讓對話框稍微重疊圖片，看起來更自然

                // 對話框
                Text(gameMessage)
                    .font(.title) // 字體更大
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
                            .rotationEffect(.degrees(180))
                            .offset(x: -15, y: 0) // 微調箭頭位置，根據對話框大小調整
                        , alignment: .leading
                    )
                    .padding(.horizontal, 20) // 對話框內邊距
            }
            .padding(.bottom, 20) // 整個 HStack 底部留白

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow.opacity(0.2)) // 上半部背景色
    }
}
