//
//  BottleGameView.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/9.
//

import SwiftUI

struct BottleGameView: View {
    // 接收從 DifficultySelectionView 傳遞過來的杯子數量
    let numberOfCups: Int

    var body: some View {
        VStack {
            Text("幾 A 幾 B 遊戲")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            Text("你選擇了：**\(numberOfCups)** 個杯子！")
                .font(.title2)
                .padding(.bottom, 40)

            // --- 你的遊戲邏輯和介面會在這裡實作 ---
            // 例如：
            // Text("請輸入你的猜測：")
            // TextField("猜測數字", text: $guessInput) // 需要一個 @State 變數來綁定輸入
            // Button("送出猜測") {
            //     // 處理猜測邏輯
            // }
            // Text("猜測紀錄與提示會顯示在這裡...")
            // --- 你的遊戲邏輯和介面會在這裡實作 ---

            Spacer()
        }
        // 設定這個 View 的導航列標題
        // 通常在遊戲頁面會顯示遊戲名稱
        .navigationTitle("遊戲進行中")
        .navigationBarTitleDisplayMode(.inline) // 讓標題顯示在中間
        // 如果你希望遊戲頁面沒有返回按鈕，可以隱藏導航列，但通常遊戲會需要返回主選單
        // .navigationBarHidden(true)
    }
}

// 預覽功能
struct BottleGameView_Previews: PreviewProvider {
    static var previews: some View {
        // 在預覽時，你可以給一個預設的杯子數量來查看效果
        BottleGameView(numberOfCups: 8)
    }
}
