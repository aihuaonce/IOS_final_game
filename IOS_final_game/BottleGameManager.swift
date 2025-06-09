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
    @Published var secretSequence: [CupColor] // 目標杯子顏色序列（秘密數字）
    @Published var playerSequence: [CupColor] // 玩家當前操作的杯子序列

    private let numberOfCups: Int // 遊戲的杯子總數 (難度)

    init(numberOfCups: Int) {
        self.numberOfCups = numberOfCups
        // 確保至少有 4 個杯子用於幾A幾B的4位數
        let actualNumberOfCups = max(4, numberOfCups)
        
        // 1. 生成秘密序列
        // 假設秘密數字是 4 位數，且數字不能重複
        // 我們從 CupColor 的所有案例中選擇前 actualNumberOfCups 個顏色
        var allPossibleColors = Array(CupColor.allCases.prefix(actualNumberOfCups))
        allPossibleColors.shuffle() // 打亂所有可能顏色的順序

        // 取前 4 個作為秘密序列 (如果你的幾A幾B是4位數)
        // 你可以根據遊戲規則調整這個「秘密數字」的位數
        self.secretSequence = Array(allPossibleColors.prefix(4))
        
        // 2. 生成玩家序列 (打亂的初始序列)
        var initialPlayerColors = Array(allPossibleColors.prefix(4)) // 確保位數和秘密序列一致
        initialPlayerColors.shuffle() // 打亂玩家序列
        self.playerSequence = initialPlayerColors

        print("秘密序列: \(secretSequence.map { $0.rawValue })")
        print("玩家初始序列: \(playerSequence.map { $0.rawValue })")
    }

    // MARK: - 玩家操作
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

    // MARK: - 檢查 A B 結果
    func checkGuess() -> GuessResult {
        var aCount = 0
        var bCount = 0

        // 建立一個秘密序列的副本，方便檢查 B 時排除已匹配的 A
        var secretTemp = secretSequence.map { $0.rawValue }
        var playerTemp = playerSequence.map { $0.rawValue }

        // 檢查 A
        for i in 0..<playerSequence.count {
            if playerTemp[i] == secretTemp[i] {
                aCount += 1
                playerTemp[i] = "MATCHED_A" // 標記為已匹配
                secretTemp[i] = "MATCHED_A" // 標記為已匹配
            }
        }

        // 檢查 B
        for i in 0..<playerSequence.count {
            if playerTemp[i] != "MATCHED_A" { // 如果這個數字還沒有被 A 匹配
                if let secretIndex = secretTemp.firstIndex(of: playerTemp[i]) {
                    bCount += 1
                    secretTemp[secretIndex] = "MATCHED_B" // 標記為已匹配
                }
            }
        }
        
        return GuessResult(A: aCount, B: bCount)
    }
}
