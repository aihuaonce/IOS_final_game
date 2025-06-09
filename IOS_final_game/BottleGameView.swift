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
    let numberOfCups: Int
    
    @StateObject private var gameManager: GameManager
    @State private var firstSelectedIndex: Int? = nil
    
    @State private var gameMessage: String = "請交換方塊來猜測順序。"
    @State private var hasGuessed: Bool = false
    
    init(numberOfCups: Int) {
        self.numberOfCups = numberOfCups
        _gameManager = StateObject(wrappedValue: GameManager(numberOfValue: numberOfCups))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 使用 GameHeaderView 來替換上半部複雜的 View 結構
            // 透過 $gameMessage 將 gameMessage 的 Binding 傳遞給 GameHeaderView
            GameHeaderView(gameMessage: $gameMessage)
            
            // MARK: - 分隔線 (模擬木板)
            Rectangle()
                .fill(Color.brown)
                .frame(height: 10)
                .overlay(
                    Rectangle()
                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                )
            
            // MARK: - 下半部：杯子排列區
            VStack {
                Text("你的順序")
                    .font(.largeTitle)
                    .padding(.bottom, 30)
                
                Spacer()
                // --- 根據總杯子數量，平均分兩列 ---
                let totalCups = gameManager.playerSequence.count
                // 計算第一列的杯子數量 (總數除以 2，無條件進位)
                let firstRowItemCount = (totalCups + 1) / 2
                
                let firstRowCups = Array(gameManager.playerSequence.prefix(firstRowItemCount))
                let secondRowCups = Array(gameManager.playerSequence.suffix(max(0, totalCups - firstRowItemCount)))
                // --- 根據總杯子數量，平均分兩列 ---
                
                // 第一列
                HStack(spacing: 15) {
                    ForEach(firstRowCups.indices, id: \.self) { indexInRow in
                        let actualIndex = indexInRow
                        CupView(color: firstRowCups[indexInRow],
                                isTarget: false,
                                isSelected: self.firstSelectedIndex == actualIndex)
                        .onTapGesture {
                            self.handleCupTap(at: actualIndex)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, !secondRowCups.isEmpty ? 5 : 0) // 如果有第二行，則加上底部間距
                
                // 第二列 (只有當有第二列的杯子時才顯示)
                if !secondRowCups.isEmpty {
                    HStack(spacing: 15) {
                        ForEach(secondRowCups.indices, id: \.self) { indexInRow in
                            let actualIndex = indexInRow + firstRowItemCount // 第二列的實際索引需要加上第一列的數量
                            CupView(color: secondRowCups[indexInRow],
                                    isTarget: false,
                                    isSelected: self.firstSelectedIndex == actualIndex)
                            .onTapGesture {
                                self.handleCupTap(at: actualIndex)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green.opacity(0.2))
        }
        .navigationTitle("幾 A 幾 B 遊戲")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func handleCupTap(at index: Int) {
        if firstSelectedIndex == nil {
            firstSelectedIndex = index
        } else if firstSelectedIndex == index {
            firstSelectedIndex = nil
        } else {
            withAnimation(.easeInOut(duration: 0.3)) {
                gameManager.swapCups(index1: firstSelectedIndex!, index2: index)
            }
            
            let result = gameManager.checkGuess()
            gameMessage = "\(result.A) A \(result.B) B"
            hasGuessed = true
            
            firstSelectedIndex = nil
            
            if result.A == gameManager.secretSequence.count {
                gameMessage = "恭喜！\n你答對了！"
            }
        }
    }
}
// 預覽功能
struct BottleGameView_Previews: PreviewProvider {
    static var previews: some View {
        BottleGameView(numberOfCups: 9)
    }
}
