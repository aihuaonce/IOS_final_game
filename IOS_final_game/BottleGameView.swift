//
//  BottleGameView.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/9.
//

import SwiftUI

// 用來表示杯子的顏色。你可以擴展這個 enum 加入更多顏色。
enum CupColor: String, CaseIterable, Identifiable {
    case red, blue, green, yellow, orange, purple, cyan, magenta, brown, white

    var id: String { self.rawValue }

    // 方便顯示顏色的 View
    var swiftUIColor: Color {
        switch self {
        case .red: return .red
        case .blue: return .blue
        case .green: return .green
        case .yellow: return .yellow
        case .orange: return .orange
        case .purple: return .purple
        case .cyan: return .cyan
        case .magenta: return .pink
        case .brown: return .brown
        case .white: return .white
        }
    }
}

// BottleGameView 的主要結構
struct BottleGameView: View {
    // 接收從 DifficultySelectionView 傳遞過來的杯子數量
    let numberOfCups: Int

    // MARK: - 遊戲狀態
    // @StateObject 用於管理複雜的、需要生命週期管理的物件，例如遊戲管理器
    @StateObject private var gameManager: GameManager

    // @State 用於追蹤玩家點擊了哪個杯子的索引
    @State private var firstSelectedIndex: Int? = nil

    // @State 用於控制火柴人對話框的內容
    @State private var gameMessage: String = "請交換杯子來猜測順序！"

    // MARK: - 初始化
    // 透過 init 根據 numberOfCups 初始化 GameManager
    init(numberOfCups: Int) {
        self.numberOfCups = numberOfCups
        _gameManager = StateObject(wrappedValue: GameManager(numberOfCups: numberOfCups))
    }

    // MARK: - View Body
    var body: some View {
        VStack(spacing: 0) { // 整體垂直堆疊，間距為0以利分隔線
            // MARK: - 上半部：火柴人與對話框
            VStack {
                Spacer() // 將內容往中間推

                Image("matchstick_man") // 你的火柴人圖片，請確保在 Assets.xcassets 中有此圖檔
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.bottom, 10)

                // 對話框
                Text(gameMessage)
                    .font(.title2)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white) // 對話框背景
                            .shadow(radius: 3)
                    )
                    .overlay( // 模擬對話框的箭頭
                        Triangle()
                            .fill(Color.white)
                            .frame(width: 20, height: 15)
                            .rotationEffect(.degrees(180)) // 讓箭頭向下
                            .offset(y: 10) // 調整位置
                        , alignment: .bottom
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20) // 與下方分隔線的距離

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow.opacity(0.2)) // 上半部背景色

            // MARK: - 分隔線 (模擬木板)
            Rectangle()
                .fill(Color.brown) // 木板顏色
                .frame(height: 10) // 木板高度
                .overlay( // 模擬木板紋理（可選）
                    Rectangle()
                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                )

            // MARK: - 下半部：杯子排列區
            VStack {
                Spacer()

                Text("目標順序")
                    .font(.headline)
                    .padding(.bottom, 5)

                // 預設（目標）杯子排序 - 使用 HStack
                HStack(spacing: 5) {
                    ForEach(gameManager.secretSequence) { cupColor in
                        CupView(color: cupColor, isTarget: true)
                    }
                }
                .padding(.bottom, 20)

                Text("你的順序")
                    .font(.headline)
                    .padding(.bottom, 5)

                // 玩家操作的杯子排序 - 使用 HStack 和手勢
                HStack(spacing: 5) {
                    ForEach(gameManager.playerSequence.indices, id: \.self) { index in
                        CupView(color: gameManager.playerSequence[index],
                                isTarget: false,
                                isSelected: self.firstSelectedIndex == index) // 根據選擇狀態改變樣式
                            .onTapGesture {
                                self.handleCupTap(at: index) // 處理杯子點擊事件
                            }
                    }
                }
                .padding(.bottom, 20)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green.opacity(0.2)) // 下半部背景色
        }
        .navigationTitle("幾 A 幾 B 遊戲") // 遊戲頁面的導航列標題
        .navigationBarTitleDisplayMode(.inline)
        // 在這裡可以加入返回按鈕或離開遊戲的邏輯
    }

    // MARK: - 私有函數：處理杯子點擊
    private func handleCupTap(at index: Int) {
        if firstSelectedIndex == nil {
            // 第一次點擊，記錄索引
            firstSelectedIndex = index
        } else if firstSelectedIndex == index {
            // 點擊同一個杯子，取消選擇
            firstSelectedIndex = nil
        } else {
            // 第二次點擊，交換杯子並檢查結果
            withAnimation(.easeInOut(duration: 0.3)) {
                gameManager.swapCups(index1: firstSelectedIndex!, index2: index)
            }
            
            // 檢查 A B 結果並更新訊息
            let result = gameManager.checkGuess()
            gameMessage = "\(result.A) A \(result.B) B"
            
            // 重置選擇
            firstSelectedIndex = nil

            // 判斷遊戲是否勝利
            if result.A == gameManager.secretSequence.count { // 如果 A 的數量等於總杯子數，表示勝利
                gameMessage = "恭喜！你答對了！"
                // 這裡可以加入勝利後的處理，例如彈出視窗、重置遊戲等
            }
        }
    }
}
