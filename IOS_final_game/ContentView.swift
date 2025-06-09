//
//  ContentView.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // 使用 NavigationView 讓你可以輕鬆地從這個畫面導航到其他畫面
        NavigationView {
            // 最外層使用 VStack 來垂直堆疊所有元素
            VStack {
                // 頂部的 Spacer 將標題推向中心，也可以調整高度來控制標題位置
                Spacer()

                // 遊戲標題
                Text("...遊戲")
                    .font(.largeTitle) // 設定字體大小為大標題
                    .fontWeight(.bold) // 設定字體為粗體
                    .foregroundColor(.blue) // 設定文字顏色為藍色，符合圖片樣式
                    .padding(.bottom, 50) // 在標題下方增加一些空間

                // 瓶子按鈕
                Button(action: {
                    // TODO: 在這裡定義點擊「瓶子」按鈕時要執行的動作
                    print("瓶子按鈕被點擊了！")
                    // 例如：導航到瓶子相關的遊戲畫面
                    // self.showBottleGame = true // 假設你有一個 @State 變數控制導航
                }) {
                    Text("瓶子遊戲")
                        .font(.title2) // 按鈕文字大小
                        .fontWeight(.semibold) // 按鈕文字粗細
                        .foregroundColor(.black) // 按鈕文字顏色
                        .padding(.vertical, 15) // 垂直內邊距
                        .padding(.horizontal, 80) // 水平內邊距
                        .background(
                            RoundedRectangle(cornerRadius: 10) // 圓角矩形背景
                                .stroke(Color.black, lineWidth: 2) // 黑色邊框
                        )
                }
                .padding(.bottom, 20) // 在「瓶子」按鈕下方增加空間

                // 房子按鈕
                Button(action: {
                    // TODO: 在這裡定義點擊「房子」按鈕時要執行的動作
                    print("房子按鈕被點擊了！")
                    // 例如：導航到房子相關的遊戲畫面
                    // self.showHouseGame = true // 假設你有一個 @State 變數控制導航
                }) {
                    Text("數小人遊戲")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 80)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }

                // 底部的 Spacer 將按鈕推向中心，也可以調整高度
                Spacer()
            }
            .navigationBarHidden(true) // 隱藏 NavigationView 預設的導航欄
            .navigationTitle("") // 清空導航標題（雖然隱藏了，但習慣上會設置）
        }
    }
}

// Preview 可以在 Xcode 中即時預覽你的畫面
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
