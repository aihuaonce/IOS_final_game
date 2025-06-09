//
//  BottleGameManager.swift
//  IOS_final_game
//
//  Created by 11144137 on 2025/6/9.
//

import Foundation // 引入 Foundation 框架

// 檢查結果的 struct
struct GuessResult {
    let A: Int // 數字和位置都正確的數量
    let B: Int // 數字正確但位置不正確的數量
}

// GameManager 負責遊戲的狀態和核心邏輯
class GameManager: ObservableObject {
    @Published var secretSequence: [CupColor]
    @Published var playerSequence: [CupColor]

    private let numberOfValue: Int // 將 numberOfCups 更名為 numberOfValue，以符合上下文

    // 修改 init 參數名稱以匹配
    init(numberOfValue: Int) {
        self.numberOfValue = numberOfValue // 現在 numberOfValue 就是遊戲的位數

        // 確保從 CupColor 中至少有足夠的顏色可以用來生成序列
        let availableColors = Array(CupColor.allCases.prefix(numberOfValue))
        
        guard availableColors.count >= numberOfValue else {
            fatalError("CupColor 的數量不足以支援選擇的難度 \(numberOfValue)")
        }

        // 生成秘密序列，長度就是 numberOfValue
        let tempColors = availableColors.shuffled()
        self.secretSequence = Array(tempColors.prefix(numberOfValue))
        
        // 生成玩家初始序列，長度也是 numberOfValue
        let initialPlayerColors = tempColors.shuffled() // 再次打亂，確保和秘密序列不同
        self.playerSequence = Array(initialPlayerColors.prefix(numberOfValue))

        print("秘密序列 (位數: \(numberOfValue)): \(secretSequence.map { $0.rawValue })")
        print("玩家初始序列 (位數: \(numberOfValue)): \(playerSequence.map { $0.rawValue })")
    }

    func swapCups(index1: Int, index2: Int) {
        guard index1 >= 0 && index1 < playerSequence.count,
              index2 >= 0 && index2 < playerSequence.count,
              index1 != index2 else {
            print("無效的交換索引")
            return
        }
        playerSequence.swapAt(index1, index2)
        print("交換後玩家序列: \(playerSequence.map { $0.rawValue })")
    }

    func checkGuess() -> GuessResult {
        var aCount = 0
        var bCount = 0

        var secretTemp = secretSequence.map { $0.rawValue }
        var playerTemp = playerSequence.map { $0.rawValue }

        for i in 0..<playerSequence.count {
            if playerTemp[i] == secretTemp[i] {
                aCount += 1
                playerTemp[i] = "MATCHED_A"
                secretTemp[i] = "MATCHED_A"
            }
        }

        for i in 0..<playerSequence.count {
            if playerTemp[i] != "MATCHED_A" {
                if let secretIndex = secretTemp.firstIndex(of: playerTemp[i]) {
                    bCount += 1
                    secretTemp[secretIndex] = "MATCHED_B"
                }
            }
        }
        
        return GuessResult(A: aCount, B: bCount)
    }
}
